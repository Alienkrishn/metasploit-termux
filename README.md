<div align="center">

<img src="https://www.metasploit.com/includes/images/metasploit-logo-light-external-use.svg" alt="Metasploit Termux Logo" width="500">

# 🦠 Metasploit Termux

**Metasploit Framework 6.4.135 for Termux — Simple, patched, and working.**

[![Version](https://img.shields.io/badge/Version-6.4.135-red?style=for-the-badge&logo=metasploit&logoColor=white)](#-about)
[![Platform](https://img.shields.io/badge/Platform-Termux-green?style=for-the-badge&logo=android&logoColor=white)](#-installation)
[![Author](https://img.shields.io/badge/Author-Alienkrishn_%5BAnon4you%5D-blueviolet?style=for-the-badge)](#-about)

<br>

<details>
<summary><b>📸 Click to view screenshot</b></summary>
<br>
<img src="assets/msf_img.jpg" alt="Metasploit Termux Screenshot" width="700">
</details>

<br>

</div>

---

## 📋 About

A simple and reliable script to install the **Metasploit Framework 6.4.135** directly on your Android device via Termux. 

Unlike other buggy scripts, this installer includes **actual patches**—such as fixing the notorious `nokogiri gumbo parser error`—to ensure Metasploit runs smoothly in the Termux environment. As a bonus, it also automatically installs **apktool** for your Android payload crafting needs.

> [!WARNING]
> **Disclaimer:** Metasploit is a powerful penetration testing tool. This script was built for educational purposes and authorized security testing only. The author is **not responsible** for any misuse, illegal activities, or damage caused by this tool. Always obtain explicit permission before testing any systems or networks.

---

## 🚀 Installation

Run the following command in your Termux terminal:

```bash
curl -sL https://github.com/Alienkrishn/metasploit-termux/raw/main/msf_termux.sh | bash
```

Sit back and let the script handle the dependencies, patches, and setup process.

---

## 🗑️ Uninstall

If you ever need to remove Metasploit from your Termux environment, simply run:

```bash
curl -sL https://github.com/Alienkrishn/metasploit-termux/raw/main/msf_uninstall.sh | bash
```

---

> [!NOTE]
> Make sure you are using a clean and updated Termux environment (`pkg update && pkg upgrade`) before running the installation for the best experience.

---

<div align="center">

**Author: Alienkrishn [Anon4you]**

</div>
