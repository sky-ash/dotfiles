#!/bin/bash

backup=$HOME/dotfiles/backup.latest/
rm -rf $backup
mkdir -p $backup

pwd=$(pwd)
dotfiles="$pwd"

mkdir -p ~/.config/dotfiles
echo "$dotfiles" > ~/.config/dotfiles/repositoryLocalPath.cache



####################################################################################
####################################################################################
####################################################################################




check_install_yay() {
	if ! pacman -Qq yay &>/dev/null; then
		echo "Yay is required to install packages. Checking if git is installed..."
		if ! pacman -Qq git &>/dev/null; then
			echo "Git is not installed. Installing git..."
			dependenciessudo pacman -S git --noconfirm
			echo "Git has been installed."
		else
			echo "Git is already installed."
		fi
		
		echo "Proceeding with yay installation..."
		cd ~
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd ..dependencies
		yay -Syu --noconfirm
	fi
}




# List of packages to install
dependencies=$(cat ~/.config/dotfiles/dependencies.csv)

# Check if yay is installed
check_install_yay

# Install dependencies
echo "install dependencies with yay? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
	echo "Installing packages with yay..."
	yay -S --noconfirm --needed $dependencies
else
	echo "WARNING: SKIPPING DEPENDENCY INSTALLATION."
fi




####################################################################################
####################################################################################
####################################################################################




update_config() {

	config_dir="$dotfiles/dotfiles/.config/"

	echo -e "now copying all folders from '$config_dir' to '~/.config'\n"

	for dir in $(ls -A "$config_dir"); do
		echo "CHECKING $dir:"
		if [[ -d "$config_dir/$dir" ]]; then
			echo -e "'$dir' is a diretory. copying to home-directory.\n"
			cp -r "$HOME/.config/$dir" "$backup/"
			rm -rf "$HOME/.config/$dir"
			cp -r "$config_dir/$dir" "$HOME/.config/"
		else
			echo -e "skipping: '$dir' is a file.\n"
		fi
	done
}

copy_wallpaper_folder() {

	source="$dotfiles/dotfiles/wallpaper"
	target="$HOME/.wallpaper"

	mkdir -p "$target"
	echo -e "now copying folder as a whole from '$source' to '$target'\n"
	cp -r "$source"/* "$target/"
	echo -e "finished copying folder from '$source' to '$target'\n"
}

copy_files_to_home() {

	source="$dotfiles/dotfiles/"
	target="$HOME"

	for file in $(ls -A "$source"); do
		echo "CHECKING $file:"
		if [[ -f "$source/$file" ]]; then
			echo -e "'$file' is a file. copying to home-directory.\n"
			cp -r "$HOME/$file" "$backup/"
			rm -rf "$HOME/$file"
			cp -r "$source/$file" "$target/"
		else
			echo -e "skipping: '$file' is a directory.\n"
		fi
	done
}




update_config
copy_wallpaper_folder
copy_files_to_home

echo "Installation complete."