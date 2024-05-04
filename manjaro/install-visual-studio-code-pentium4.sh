#!/bin/bash
sudo pacman -S debugedit fakeroot
PACKAGE_NAME=visual-studio-code-bin
TMP_DIRECTORY=/tmp
if [ ! -d "$TMP_DIRECTORY" ]; then
  echo "Temp Directory \"$TMP_DIRECTORY\" DOES NOT exists!"
  exit 1
fi
cd $TMP_DIRECTORY
rm -rf "${PACKAGE_NAME}"
git clone https://aur.archlinux.org/${PACKAGE_NAME}.git "${PACKAGE_NAME}"
cd "${PACKAGE_NAME}"
git checkout 2535441808103a8ba9004426dbabab37167261e3 # 1.32.3
sed -E "s/i686/pentium4/g" -i PKGBUILD
sed -E "s/https:\/\/vscode-update\.azurewebsites\.net\//https:\/\/update.code.visualstudio.com\//g" -i PKGBUILD
makepkg -s
PACKAGE_INSTALL=`ls | grep -E '\.tar\.xz|\.tar\.zst' | grep -v orig`
sudo pacman -U $PACKAGE_INSTALL
cd ..
rm -rf "${PACKAGE_NAME}"
