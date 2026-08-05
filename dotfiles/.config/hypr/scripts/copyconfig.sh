config=$HOME/.config/
dotfiles=$HOME/Desktop/dotfiles/dotfiles/
dotfiles_config=$HOME/Desktop/dotfiles/dotfiles/.config/


config_folders=(btop catnap cava era hypr kitty nwg-look rofi swaync waybar)
#config_folders=(hypr)

# delete config folders in home/.config and copy folders from dotfiles/.config/ to ~/.config/
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

# delete files in home and create symlinks from the dotfiles to home
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

# reloading hyprland config
echo -e "running 'hyprctl reload' to reevaluate hyprland.lua:\n"
hyprctl reload

# restart waybar
echo -e "restarting waybar:\n"
killall waybar
nohup waybar > /dev/null 2>&1 &
echo -e "waybar running.\n"

# reload swaync config and css
swaync-client -R
swaync-client -rs

# reload wallpaper (next in iteration) and update color-scheme
~/.config/hypr/scripts/next-wallpaper-and-colorscheme