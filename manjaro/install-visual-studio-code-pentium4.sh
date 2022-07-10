#!/bin/bash
PACKAGE_NAME=visual-studio-code-bin
TMP_DIRECTORY=/tmp
if [ ! -d "$TMP_DIRECTORY" ]; then
  echo "Temp Directory \"$TMP_DIRECTORY\" DOES NOT exists!"
  exit 1
fi
cd $TMP_DIRECTORY
curl "https://aur.archlinux.org/cgit/aur.git/snapshot/${PACKAGE_NAME}.tar.gz" --output "${PACKAGE_NAME}.tar.gz"
tar -zxvf "${PACKAGE_NAME}.tar.gz"
cd "${PACKAGE_NAME}"
sed -E "s/i686/pentium4/g" -i PKGBUILD
sed -E "s/\s*install -Dm 644 .+\\/bash\\/code.+//g" -i PKGBUILD
sed -E "s/\s*install -Dm 644 .+\\/zsh\\/_code.+//g" -i PKGBUILD
makepkg -s
PACKAGE_INSTALL=`ls | grep -E '\.tar\.xz|\.tar\.zst' | grep -v orig`
sudo pacman -U $PACKAGE_INSTALL
cd ..
rm -rf "${PACKAGE_NAME}"
rm "${PACKAGE_NAME}.tar.gz"
