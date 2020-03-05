#!/bin/bash
PACKAGE_NAME=$1
cd /tmp
curl "https://aur.archlinux.org/cgit/aur.git/snapshot/${PACKAGE_NAME}.tar.gz" --output "${PACKAGE_NAME}.tar.gz"
tar -zxvf "${PACKAGE_NAME}.tar.gz"
cd "${PACKAGE_NAME}"
makepkg -s
PACKAGE_INSTALL=`ls | grep .tar.xz | grep -v orig`
sudo pacman -U $PACKAGE_INSTALL
cd ..
rm -rf "${PACKAGE_NAME}"
rm "${PACKAGE_NAME}.tar.gz"
