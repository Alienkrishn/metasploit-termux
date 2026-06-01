#!/usr/bin/env bash
# Uninstaller for metasploit 

MSFPATH="$PREFIX/opt/metasploit-framework"
# Remove any symlink that points to MSFPATH
find "$PREFIX/bin" -type l -lname "$MSFPATH/*" -exec rm -f {} \;
rm -rf "$MSFPATH"

# Standard removal
rm -rf "$PREFIX/share/apktool" "$PREFIX/bin/apktool" 2>/dev/null
echo "Removing Nokogiri gem..."
gem uninstall nokogiri -v 1.19.0 -x || true

# Also try to remove any other versions that might be installed
gem uninstall nokogiri -a -x -I || true

echo "Cleaning up residual files..."
[ -d "$PREFIX/lib/ruby/gems" ] && find "$PREFIX/lib/ruby/gems" -name "*nokogiri*" -exec rm -rf {} + || true

# Remove nokogiri binary from bin directory if it exists
if [ -f "$PREFIX/bin/nokogiri" ]; then
    echo "Removing nokogiri binary from $PREFIX/bin..."
    rm -f "$PREFIX/bin/nokogiri"
fi

echo "Nokogiri removal complete."echo "Removing Nokogiri gem..."
gem uninstall nokogiri -v 1.19.0 -x || true

# Also try to remove any other versions that might be installed
gem uninstall nokogiri -a -x -I || true

echo "Cleaning up residual files..."
[ -d "$PREFIX/lib/ruby/gems" ] && find "$PREFIX/lib/ruby/gems" -name "*nokogiri*" -exec rm -rf {} + || true

# Remove nokogiri binary from bin directory if it exists
if [ -f "$PREFIX/bin/nokogiri" ]; then
    echo "Removing nokogiri binary from $PREFIX/bin..."
    rm -f "$PREFIX/bin/nokogiri"
fi

echo "[+] Nokogiri removal complete."
echo "[+] APKTool completely removed"
echo "[+] Metasploit completly removed"
exit 0
