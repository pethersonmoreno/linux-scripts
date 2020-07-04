#!/bin/sh
echo 'Installing tigervnc'
sudo pacman -S tigervnc
echo "Execute vncserver to configure it. After it you can change password with vncpasswd"