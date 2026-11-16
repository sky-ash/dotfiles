dotfiles=$HOME/Desktop/dotfiles/dotfiles/

# delete config folders in ~/.config and copy folders from dotfiles/.config/ to ~/.config/
config_folders=(btop catnap cava era fish hypr kitty nwg-look rofi swaync wal waybar)
config=$HOME/.config/
dotfiles_config=$HOME/Desktop/dotfiles/dotfiles/.config/

for folder in ${config_folders[@]}; do
    echo "checking $folder:"
    if [[ -d "$config/$folder" ]]; then
        echo -e "'$folder' is a diretory. deleting and creating copy from dotfiles.\n"
        rm -rf "$config/$folder"
        cp -r "$dotfiles_config/$folder" "$config/$folder"
    else
        echo -e "skipping: '$folder' is not a directory.\n"
    fi
done

# delete files in ~/ and copy files from dotfiles/ to ~/
files=(.bashrc .bash_profile .gitconfig .xinitrc)

for file in ${files[@]}; do
    echo "checking $file:"
    if [[ -f "$HOME/$file" ]]; then
        echo -e "'$file' is a file. deleting and creating copy from dotfiles.\n"
        rm -rf "$HOME/$file"
        cp -r "$dotfiles/$file" "$HOME/$file"
    else
        echo -e "skipping: '$file' is not a file.\n"
    fi
done

# delete folders in ~/.local and copy folders from dotfiles/.local/ to ~/.local/
local_folders=(colors wallpaper scripts)
local=$HOME/.local/
dotfiles_local=$HOME/Desktop/dotfiles/dotfiles/.local/

for folder in ${local_folders[@]}; do
    echo "checking $folder:"
    if [[ -d "$local/$folder" ]]; then
        echo -e "'$folder' is a diretory. deleting and creating copy from dotfiles.\n"
        rm -rf "$local/$folder"
        cp -r "$dotfiles_local/$folder" "$local/$folder"
    else
        echo -e "skipping: '$folder' is not a directory.\n"
    fi
done

# reload all configs
~/.config/hypr/scripts/reload_all.sh
