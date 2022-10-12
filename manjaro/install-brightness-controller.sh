#!/bin/sh
sudo pacman -S python-qtpy patchelf pyside2 xorg-xrandr python-cx_freeze qt5-charts qt5-xmlpatterns qt5-speech qt5-x11extras qt5-tools qt5-svg qt5-sensors qt5-remoteobjects qt5-websockets qt5-datavis3d qt5-3d qt5-script qt5-webengine
PACKAGE_NAME=brightness-controller
TMP_DIRECTORY=/tmp
if [ $# -gt 1 ]; then
  TMP_DIRECTORY=$2
fi
if [ ! -d "$TMP_DIRECTORY" ]; then
  echo "Temp Directory \"$TMP_DIRECTORY\" DOES NOT exists!"
  exit 1
fi
cd $TMP_DIRECTORY
git clone https://github.com/LordAmit/Brightness.git "${PACKAGE_NAME}"
cd "${PACKAGE_NAME}"
git checkout 5c223a712e3ca7b2c3be6cbb0049054d9d1acc83
sudo cp -a src "/opt/${PACKAGE_NAME}"
cat <<EOF | sudo tee /opt/${PACKAGE_NAME}/${PACKAGE_NAME} 2&>/dev/null
#!/bin/sh
cd /opt/${PACKAGE_NAME}
python init.py
EOF
sudo chmod +x /opt/${PACKAGE_NAME}/${PACKAGE_NAME}
cat <<EOF | sudo tee /opt/${PACKAGE_NAME}/${PACKAGE_NAME}.desktop 2&>/dev/null
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=Brightness Controller
Comment=Control Brightness of your Primary and Secondary Display in Linux
Exec=${PACKAGE_NAME}
Icon=brightness-controller
Terminal=false
StartupNotify=false
Categories=Application;
EOF

sudo ln -s /opt/${PACKAGE_NAME}/icons/brightness-controller.svg /usr/share/pixmaps/brightness-controller.svg
sudo ln -s /opt/${PACKAGE_NAME}/${PACKAGE_NAME} /usr/local/bin/${PACKAGE_NAME}
sudo cp /opt/${PACKAGE_NAME}/${PACKAGE_NAME}.desktop /usr/share/applications/${PACKAGE_NAME}.desktop

cd $TMP_DIRECTORY
rm -rf "${PACKAGE_NAME}"

# # To remove
# PACKAGE_NAME=brightness-controller
# sudo rm -rf /opt/${PACKAGE_NAME}
# sudo rm /usr/share/pixmaps/brightness-controller.svg
# sudo rm /usr/local/bin/${PACKAGE_NAME}
# sudo rm /usr/share/applications/${PACKAGE_NAME}.desktop