#!/bin/bash

config=$HOME/.config/
src_dotfiles=$HOME/Desktop/dotfiles/dotfiles
src_dotfiles_config=$src_dotfiles/.config/
src_dotfiles_local=$src_dotfiles/.local/


# ========================================================================================
# ========================================================================================

list_of_config_folders=(btop catnap cava era fish hypr kitty nwg-look rofi swaync waybar)

# delete config folders in home/.config and copy folders from dotfiles/.config/ to ~/.config/
copy_config_folders() {
    for folder in ${list_of_config_folders[@]}; do
        echo "checking $folder:"
        if [[ -d "$config/$folder" ]]; then
            echo -e "'$folder' is a diretory. deleting and creating copy from dotfiles.\n"
            rm -rf "$config/$folder"
            cp -r "$src_dotfiles_config/$folder" "$config/$folder"
        else
            echo -e "skipping: '$folder' is not a directory.\n"
        fi
    done
}


copy_config_folders()


# ========================================================================================
# ========================================================================================

list_of_files=(.bashrc .bash_profile .xinitrc)

# delete files in ~/ and copy files from dotfiles/ to ~/
copy_files_to_home() {
    for file in ${list_of_files[@]}; do
        echo "checking $file:"
        if [[ -f "$HOME/$file" ]]; then
            echo -e "'$file' is a file. deleting and creating copy from dotfiles.\n"
            rm -rf "$HOME/$file"
            cp -r "$src_dotfiles/$file" "$HOME/$file"
        else
            echo -e "skipping: '$file' is not a file.\n"
        fi
    done
}

copy_files_to_home()


# ========================================================================================
# ========================================================================================

list_of_local_folders=(wallpaper)

# COPY WALLPAPER FOLDER (~/.local/wallpaper)
copy_local_folders() {
    for folder in ${list_of_local_folders[@]}; do
        echo "checking $folder:"
        if [[ -d "$HOME/.local/$folder" ]]; then
            echo -e "'$folder' is a diretory. deleting and creating copy from dotfiles.\n"
            rm -rf "$HOME/.local/$folder"
            cp -r "$src_dotfiles_local/$folder" "$HOME/.local/$folder"
        else
            echo -e "skipping: '$folder' is not a directory.\n"
        fi
    done
}

#copy_local_folders()


# ========================================================================================
# ========================================================================================

# reload all configs
~/.config/hypr/scripts/reload_all.sh