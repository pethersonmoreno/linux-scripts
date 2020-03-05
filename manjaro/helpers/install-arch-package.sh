#!/bin/bash
PACKAGE_NAME=$1
cd /tmp
curl "https://aur.archlinux.org/cgit/aur.git/snapshot/${PACKAGE_NAME}.tar.gz" --output "${PACKAGE_NAME}.tar.gz"
tar -zxvf "${PACKAGE_NAME}.tar.gz"
cd "${PACKAGE_NAME}"
makepkg -s
sudo pacman -U *.xz
cd ..
rm -rf "${PACKAGE_NAME}"
rm "${PACKAGE_NAME}.tar.gz"
