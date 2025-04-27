#!/bin/bash

# createCopies.sh

pwd=$(pwd)
dotfiles="$pwd/dotfiles"
configs="$dotfiles/.config/"

# cp wallpaper folder to ~/.wallpaper
if [ -d ~/.wallpaper ]; then
    rm -rf ~/.wallpaper
fi
cp -r $dotfiles/wallpaper ~/.wallpaper

# folders in $configs for ~/.config/

folder_names=(
    #"bluetuith"
    #"btop"
    #"catnap"
    #"cava"
    #"dunst"
    #"era"
    "hypr"
    "kitty"
    #"nwg-look"
    "rofi"
    #"spicetify"
    #"swaync"
    "waybar"
    #"zed"
)

for folder in "${folder_names[@]}"; do
    # first check if the folder exists. if it does, overwrite it (remove completely and replace by fresh symlink)
    if [ -d ~/.config/$folder ]; then
        rm -rf ~/.config/$folder
    fi

    cp -r $configs/$folder ~/.config/$folder
done


# dotfiles for /home/user/ (.xinitrc, .bashrc, .bash_profile, .gitconfig)
cp -r $dotfiles/.xinitrc ~/.xinitrc
cp -r $dotfiles/.bashrc ~/.bashrc
cp -r $dotfiles/.bash_profile ~/.bash_profile
cp -r $dotfiles/.gitconfig ~/.gitconfig