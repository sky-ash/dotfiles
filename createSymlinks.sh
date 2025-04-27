#

# createSymlinks.sh
# This script creates symbolic links of the specified files and directories.

# Usage: 
# 1. (uncomment the files/directories you want to create symlinks for)
# 2. ./createSymlinks.sh 

pwd=$(pwd)
dotfiles="$pwd/dotfiles"
configs="$dotfiles/.config/"

# link wallpaper folder to ~/.wallpaper
ln -sf $dotfiles/wallpaper ~/.wallpaper

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
    ln -sf $configs/$folder ~/.config/$folder
done


# dotfiles for /home/user/ (.xinitrc, .bashrc, .bash_profile, .gitconfig)
ln -sf $dotfiles/.xinitrc ~/.xinitrc
ln -sf $dotfiles/.bashrc ~/.bashrc
ln -sf $dotfiles/.bash_profile ~/.bash_profile
ln -sf $dotfiles/.gitconfig ~/.gitconfig