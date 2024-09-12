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
packages="bitwarden blueberry bluez bluez-utils brightnessctl btop catnap-git cava copyq dunst ffmpegthumbnailer file-roller firefox git grimblast-git grub hyprcursor hyprland hyprlock hyprutils imv kitty linux linux-firmware lxappearance mpv mullvad-vpn-bin nano neo-matrix-git networkmanager nwg-look obs-studio obsidian peaclock pipewire-alsa polkit-kde-agent python-ipykernel python-pip python-pywal python-pywalfox qt5-wayland qt6-wayland raw-thumbnailer rofi-lbonn-wayland-only-git sddm-git signal-desktop spicetify-cli spotify swaybg thunar thunar-archive-plugin thunar-volman ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-roboto tumbler udiskie usbutils veracrypt vimix-cursors virtualbox virtualbox-host-modules-arch vscodium vscodium-marketplace waybar xdg-desktop-portal xdg-desktop-portal-hyprland xorg-server xorg-xinit xorg-xrandr xorg-xwayland yay"

# Install packages using yay
yay -S --noconfirm --needed $packages
yay -Syyu --noconfirm