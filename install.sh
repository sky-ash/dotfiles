#!/bin/bash

mkdir -p ~/.cache/dotfiles

dots=$(pwd)/dots
echo "$dots" > ~/.cache/dotfiles/dots

backup=$HOME/.dots_backup
rm -rf $backup
mkdir -p $backup

# Update system
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
packages1="wayland wireplumber pipewire-alsa hyprland xorg-xinit xdg-desktop-portal-hyprland-git copyq dunst polkit-kde-agent kitty-git"
packages2="waybar-git rofi-lbonn-wayland-only-git sddm-git hyprlock-git hyprshot-git" # hyprcursor-git 
wallpaper="swaybg-git" # hyprpaper-git 
packages3="brightnessctl playerctl python-pywal python-pywalfox btop-git catnap-git cava-git ttf-jetbrains-mono-nerd ttf-material-design-icons-git"
thunar="file-roller raw-thumbnailer gvfs thunar thunar-volman thunar-archive-manager ffmpegthumbnailer tumbler usbutils"
packages5="firefox imv mpv nano blueberry vscodium vscodium-marketplace"
packages6="discord gimp intellij-idea-ultimate-edition mullvad-vpn-bin nano obs-studio obsidian rstudio-desktop-bin signal-desktop spotify bitwarden nomachine veracrypt"
packages7="qt5-wayland qt6-wayland"
packages8="neo-matix-git peaclock-git"

yay -S --noconfirm --needed $packages1 $packages2 $wallpaper $packages3 $packages7    #     $packages8    #  $packages5 $packages6 $thunar


update() {
	dir=$1
	echo "update function called on $dir"

	echo "copying $HOME/$dir to $backup/"
	cp -r $HOME/$dir $backup/
	echo "finished copying $HOME/$dir to $backup/"

	echo "now iterating over $dots/$dir"
	for f in $(ls -A $dots/$dir); do
		echo "removing $HOME/$dir/$f, then copying $dots/$dir/$f to $HOME/$dir/"

		rm -rf $HOME/$dir/$f
		cp -r $dots/$dir/$f $HOME/$dir/
	done

	echo "finished updating $dir"
}

for f in $(ls -A $dots); do

	echo "checking $f"
	if [[ -f $f ]]; then
		echo "$f is a file"
		cp -r $HOME/$f $backup/
		rm -rf $HOME/$f
		cp -r $dots/$f $HOME/
	else
		echo "skipping: $f is a directory."
	fi
done

update .config
update .local/bin
update .local/share

echo "Installation complete."