#!/bin/bash
CURRENT_DIRECTORY=`pwd`
sudo pacman -S retroarch
cd $CURRENT_DIRECTORY
sed -i '/^input_player1_/d' ~/.config/retroarch/retroarch.cfg && cat retroarch_input-player1.cfg >> ~/.config/retroarch/retroarch.cfg && echo >> ~/.config/retroarch/retroarch.cfg
