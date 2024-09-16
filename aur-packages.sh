#!/bin/bash

# Check if yay is installed
if ! pacman -Qq yay &>/dev/null; then
    # Install yay
    cd ~
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    yay -Syu --noconfirm
fi

# List of packages to install
packages=$(cat all-packages.txt)

# Install packages using yay
yay -S --noconfirm --needed $packages
yay -Syyu --noconfirm