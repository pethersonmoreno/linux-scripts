#!/bin/sh
echo 'Installing remmina'
sudo pacman -S remmina
echo 'Installing freerdp to RDP support'
sudo pacman -S freerdp
echo 'Installing libvncserver to VNC support'
sudo pacman -S libvncserver
echo 'Installing rdesktop plugin to remmina'
./helpers/install-arch-package.sh remmina-plugin-rdesktop