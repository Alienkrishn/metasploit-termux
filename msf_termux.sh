#!/usr/bin/env bash
# Metasploit Framework 6.4.135 in termux

# Simple and working script wity actual patches
# Global variabals

MSFPATH="$PREFIX/opt/metasploit-framework"
TAG="6.4.135"
ZIP_URL="https://github.com/rapid7/metasploit-framework/archive/refs/tags/${TAG}.zip"

APKTOOL_DIR="$PREFIX/share/apktool"
LAUNCHER="$PREFIX/bin/apktool"
JAR_URL="https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_3.0.2.jar"

# updating repositoryI
echo "[*] Updating Packages repositories ..."
apt update && apt upgrade -y

# Required pkgs for metasploit
echo "[*] Installing dependencies ..."
apt install -y binutilsi \
    python \
    autoconf \
    bison \
    clang \
    coreutils \
    curl \
    findutils \
    apr \
    apr-util \
    postgresql \
    openssl \
    readline \
    libffi \
    libgmp \
    libpcap \
    libsqlite \
    libgrpc \
    libtool \
    libxml2 \
    libxslt \
    ncurses \
    make \
    ncurses-utils \
    git \
    wget \
    unzip \
    zip \
    tar \
    termux-tools \
    termux-elf-cleaner \
    pkg-config \
    ruby \
    apksigner \
    gumbo-parser \
    gumbo-parser-static

# Apktool is also required let's install it manualy since it's not available in termux
#
[ -d "$APKTOOL_DIR" ] && rm -rf "$APKTOOL_DIR"

echo "[*] Setting up APKTool ..."
mkdir -p "$APKTOOL_DIR" && cd "$APKTOOL_DIR" || exit 1

echo "[*] Downloading ..."
wget -q --show-progress "$JAR_URL" -O apktool.jar || {
    mv "$APKTOOL_DIR" "$APKTOOL_DIR-failed"
    echo -e "\n[!] Download failed (Code:$?). Try:"
    echo "    1. Check internet"
    echo "    2. wget '$JAR_URL'"
    exit 1
}

echo "[*] Creating launcher..."
cat > "$LAUNCHER" <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
exec java -jar "$PREFIX/share/apktool/apktool.jar" "$@"
EOF
chmod +x "$LAUNCHER"

# aptool is installed now let's install nokgiri gem it's requrired fot metsploit we also need to fix gumbo parser
#
# create include dir if not exists and download header file
#
echo "[*] Downloading Nokogiri Gumbo Header ..."
mkdir -p $PREFIX/include
curl -L https://github.com/Alienkrishn/metasploit-termux/raw/main/assets/nokogiri_gumbo.h -o $PREFIX/include/nokogiri_gumbo.h

# with this nokogiri installation is fixed simple now lets install it with sys libs
echo "[*] Installing Nokogiri gem ..."
gem install nokogiri -v 1.19.0 -- --use-system-libraries

# check if its installed
echo "Verifying installation..."
ruby -rnokogiri -e "puts Nokogiri::VERSION" || {
    echo "Nokogiri installation failed!" >&2
    exit 1
}


# now we can move furthur sorry my english is bad
echo "[*] Metasploit Installation started ..."
[ -d "$MSFPATH" ] && rm -rf "$MSFPATH"

wget -q "$ZIP_URL" -O "$TMPDIR/msf.zip"
unzip -q "$TMPDIR/msf.zip" -d "$TMPDIR"
mv "$TMPDIR/metasploit-framework-${TAG}" "$MSFPATH"
rm -f "$TMPDIR/msf.zip"

cd "$MSFPATH"

gem install bundler

# Extract exact versions from Gemfile.lock
DATE_VER=$(grep "^    date (" Gemfile.lock | awk '{print $2}' | tr -d '()')
ACTIONVIEW_VER=$(grep "actionview (" Gemfile.lock | awk '{print $2}' | tr -d '()')
NET_VER=$(grep "network_interface (" Gemfile.lock | awk '{print $2}' | tr -d '()')

# Install date gem with exact version (single equals in the argument is fine)
gem install date -v "$DATE_VER" --no-document

# Install network_interface with workaround
gem install network_interface -v "$NET_VER" -- --with-cflags="-Wno-error=implicit-function-declaration" 2>/dev/null || true

# Remove lock file and add actionview with correct version using single equals
rm -f Gemfile.lock
bundle add actionview --version "$ACTIONVIEW_VER"

bundle config set documentation false
bundle install -j$(nproc --all)
bundle update --bundler

# Symlink all executable files in the root of MSFPATH (non‑extension files that are executable)
find "$MSFPATH" -maxdepth 1 -type f -executable -not -name "*.rb" -not -name "*.sh" -not -name "*.ru" -not -name "*.pl" | while read file; do
    binname=$(basename "$file")
    ln -sf "$file" "$PREFIX/bin/$binname"
done

echo "Metasploit-Framework $TAG installed successfully"
echo "Run 'msfconsole' or 'msfvenom'"
exit 0

# that's is mf why were you even strugling with it 
