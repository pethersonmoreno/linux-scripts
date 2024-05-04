#!/bin/bash
TMP_DIRECTORY=/tmp
PACKAGE_NAME=sublime_text
PACKAGE_FILE="sublime_text_3_build_3211_x32.tar.bz2"
if [ ! -d "$TMP_DIRECTORY" ]; then
  echo "Temp Directory \"$TMP_DIRECTORY\" DOES NOT exists!"
  exit 1
fi
cd $TMP_DIRECTORY
rm -rf "${PACKAGE_NAME}"
rm -f "${PACKAGE_NAME}.tar.bz2"
curl "https://download.sublimetext.com/$PACKAGE_FILE" --output "${PACKAGE_NAME}.tar.bz2"
tar -jxvf "${PACKAGE_NAME}.tar.bz2"
sudo rm -rf "/opt/${PACKAGE_NAME}"
sudo rm -f /usr/bin/sublime_text
sudo rm -f /usr/bin/subl
sudo mv sublime_text_3 "/opt/${PACKAGE_NAME}"
sudo ln -s "/opt/${PACKAGE_NAME}/sublime_text" /usr/bin/sublime_text
sudo ln -s sublime_text /usr/bin/subl
sudo cp -a "/opt/${PACKAGE_NAME}/sublime_text.desktop" /usr/share/applications/
sudo cp -a "/opt/${PACKAGE_NAME}/Icon/128x128/sublime-text.png" /usr/share/icons/
rm -f "${PACKAGE_NAME}.tar.bz2"
