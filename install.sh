#!/bin/bash

mkdir -p ~/.cache/dotfiles

dots=$(pwd)/dots
echo "$dots" > ~/.cache/dotfiles/dots

backup=$HOME/.dots_backup

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
	for f in $(ls -A $dots/$dir); do
		mkdir -p $backup/$dir
		mv -v $HOME/$dir/$f $backup/$dir
		cp -r $dots/$dir/$f $HOME/$dir/
	done
}

for f in $(ls -A $dots); do
	if [[ -f $f ]]; then
		mv -v $HOME/$f $backup
		cp -r $dots/$f $HOME/
	fi

	update .config
	update .local/bin
	update .local/share
done