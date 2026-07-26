#!/bin/bash

backup=$HOME/dotfiles/backup.latest/
rm -rf $backup
mkdir -p $backup

pwd=$(pwd)
dotfiles="$pwd"

mkdir -p ~/.config/dotfiles
echo "$dotfiles" > ~/.config/dotfiles/repositoryLocalPath.cache

##################################################################################

# Install dependencies
echo "Installing packages with yay..."
yay -S --noconfirm --needed ly kitty waybar swaybg rofi-lbonn-wayland-only-git python-pywal hyprland hyprlock hyprshot polkit-kde-agent swaync pipewire-pulse git nano nautilus firefox

##################################################################################

echo "starting systemd services..."
sudo systemctl enable --now ly.service

##################################################################################

# Installing Configs
mkdir -p ~/.config/waybar --verbose
mkdir -p ~/.config/rofi --verbose
mkdir -p ~/.config/hypr --verbose
mkdir -p ~/.config/kitty --verbose

cp -r "$dotfiles/dotfiles/.config/waybar/*" "$HOME/.config/waybar/" --verbose
cp -r "$dotfiles/dotfiles/.config/rofi/*" "$HOME/.config/rofi/" --verbose
cp -r "$dotfiles/dotfiles/.config/hypr/*" "$HOME/.config/hypr/" --verbose
cp -r "$dotfiles/dotfiles/.config/kitty/*" "$HOME/.config/kitty/" --verbose

##################################################################################

mkdir -p ~/.wallpaper --verbose
cp -r "$dotfiles/dotfiles/wallpaper/*" "$HOME/.wallpaper/" --verbose

##################################################################################

cp "$dotfiles/dotfiles/.bashrc" "$HOME/" --verbose

##################################################################################

echo "Installation completed. Automatic sysupdate + reboot..."

yay -Syyu --noconfirm
reboot