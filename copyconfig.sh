config=$HOME/.config/
dotfiles=$HOME/Desktop/dotfiles/dotfiles/.config/

config_folders=(btop catnap cava dunst era hypr kitty nwg-look rofi waybar)
#config_folders=(hypr)

# delete config folders in home/.config and copy folders from dotfiles/.config/ to ~/.config/
for folder in ${config_folders[@]}; do
    echo "checking $folder:"
    if [[ -d "$config/$folder" ]]; then
        echo -e "'$folder' is a diretory. deleting and creating symlink to dotfiles.\n"
        rm -rf "$config/$folder"
        cp -r "$dotfiles/$folder" "$config/$folder"
    else
        echo -e "skipping: '$folder' is not a directory.\n"
    fi
done

echo -e "running 'hyprctl reload' to reevaluate hyprland.lua:"
hyprctl reload


# delete files in ~/ and copy files from dotfiles/ to ~/
files=(.bashrc .bach_profile .gitconfig .xinitrc)

# delete files in home and create symlinks from the dotfiles to home
for file in ${files[@]}; do
    echo "checking $file:"
    if [[ -f "$HOME/$file" ]]; then
        echo -e "'$file' is a file. deleting and creating symlink to dotfiles.\n"
        rm -rf "$HOME/$file"
        cp -r "$dotfiles/$file" "$HOME/$file"
    else
        echo -e "skipping: '$file' is not a file.\n"
    fi
done

