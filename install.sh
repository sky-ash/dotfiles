#!/bin/bash

mkdir -p ~/.cache/dotfiles

dots=$(pwd)/dots
echo "$dots" > ~/.cache/dotfiles/dots

backup=$HOME/.dots_backup
rm -rf $backup
mkdir -p $backup

# Update system
# Check if yay is installed
check_install_yay() {
	if ! pacman -Qq yay &>/dev/null; then
		# Install yay
		cd ~
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd ..
		yay -Syu --noconfirm
	fi
}

check_install_yay

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

echo "Would you like to install packages with yay? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
	echo "Installing packages with yay..."
	yay -S --noconfirm --needed $packages1 $packages2 $wallpaper $packages3 $packages7    #     $packages8    #  $packages5 $packages6 $thunar
else 
	echo "Skipping package installation."
fi



update() {
	dir=$1
	echo -e "update function called on $dir\n"

	echo "backing up $dir (copying from ~/ to $backup"
	cp -r $HOME/$dir $backup/
	echo -e "finished copying ~/$dir to $backup\n"

	echo "now iterating over $dots/$dir"
	for f in $(ls -A $dots/$dir); do
		echo "removing $f from ~/$dir"
		rm -rf $HOME/$dir/$f
		
		echo "copying $f... from $dots/$dir to ~/$dir"
		cp -r $dots/$dir/$f $HOME/$dir/
	done

	echo -e "finished updating $dir\n"
}


echo -e "iterating over $dots to find files to copy to home-directory\n"
for f in $(ls -A $dots); do

	echo "CHECKING $f:"
	if [[ -f $dots/$f ]]; then

		echo -e "$f is a file. copying to home-directory.\n"
		cp -r $HOME/$f $backup/
		rm -rf $HOME/$f
		cp -r $dots/$f $HOME/
	else
		echo -e "skipping: $f is a directory.\n"
	fi
done

update .config
update .local/bin
update .local/share

echo "Installation complete."