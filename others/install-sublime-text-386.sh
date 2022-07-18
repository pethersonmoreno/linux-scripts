#!/bin/bash
PACKAGE_FILE="sublime_text_3_build_3211_x32.tar.bz2"
curl https://download.sublimetext.com/$PACKAGE_FILE -o /tmp/$PACKAGE_FILE
cd /tmp/
tar -jxvf $PACKAGE_FILE
sudo cp -a sublime_text_3/sublime_text.desktop /usr/share/applications/
sudo mv sublime_text_3 /opt/sublime_text
sudo ln -s /opt/sublime_text/sublime_text /usr/bin/sublime_text
sudo ln -s sublime_text /usr/bin/subl