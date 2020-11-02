#!/bin/sh
sudo pacman -S libretro-bsnes libretro-bsnes-hd libretro-bsnes2014 libretro-snes9x
sudo pacman -S sdl2_image lib32-sdl_image lib32-sdl2_image lib32-sdl_ttf
sudo pacman -S libretro-mgba # gba - Game Boy Advance
sudo pacman -S libretro-sameboy # gbc - Game Boy Color

sudo pacman -S libretro-beetle-psx # psx - Playstation
sudo pacman -S libretro-beetle-psx-hw # psx - Playstation - other
sudo pacman -S pcsx2