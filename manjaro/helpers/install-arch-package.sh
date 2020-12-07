#!/bin/bash
PACKAGE_NAME=$1
TMP_DIRECTORY=/tmp
if [ $# -gt 1 ]; then
  TMP_DIRECTORY=$2
fi
if [ ! -d "$TMP_DIRECTORY" ]; then
  echo "Temp Directory \"$TMP_DIRECTORY\" DOES NOT exists!"
  exit 1
fi
cd $TMP_DIRECTORY
curl "https://aur.archlinux.org/cgit/aur.git/snapshot/${PACKAGE_NAME}.tar.gz" --output "${PACKAGE_NAME}.tar.gz"
tar -zxvf "${PACKAGE_NAME}.tar.gz"
cd "${PACKAGE_NAME}"
makepkg -s
PACKAGE_INSTALL=`ls | grep -E '\.tar\.xz|\.tar\.zst' | grep -v orig`
sudo pacman -U $PACKAGE_INSTALL
cd ..
rm -rf "${PACKAGE_NAME}"
rm "${PACKAGE_NAME}.tar.gz"
