#!/bin/bash

mkdir -p ~/.cache/dotfiles

pwd=$(pwd)
dots="$pwd/dots"
echo "$dots" > ~/.cache/dotfiles/dots

backup=$HOME/.dots_backup
rm -rf $backup
mkdir -p $backup

check_install_yay() {
	if ! pacman -Qq yay &>/dev/null; then
		echo "Yay is required to install packages. Checking if git is installed..."
		if ! pacman -Qq git &>/dev/null; then
			echo "Git is not installed. Installing git..."
			sudo pacman -S git --noconfirm
			echo "Git has been installed."
		else
			echo "Git is already installed."
		fi
		
		echo "Proceeding with yay installation..."
		cd ~
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd ..
		yay -Syu --noconfirm
	fi
}

update() {
	dir=$1
	echo -e "update function called on '$dir\n'"

	echo "backing up '$dir' (copying from ~/ to '$backup'"
	cp -r "$HOME/$dir" "$backup/"
	echo -e "finished copying '~/$dir' to '$backup\n'"

	echo "now iterating over '$dots/$dir'"
	for f in $(ls -A "$dots/$dir"); do
		echo "removing '$f' from '~/$dir'"
		rm -rf "$HOME/$dir/$f"
		
		echo "copying '$f'... from '$dots/$dir' to '~/$dir'"
		cp -r "$dots/$dir/$f" "$HOME/$dir/"
	done

	echo -e "finished updating '$dir\n'"
}

# List of packages to install
deps=$(cat "$pwd/.install/deps.txt")

# Check if yay is installed
check_install_yay

# Install dependencies
echo "install dependencies with yay? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
	echo "Installing packages with yay..."
	yay -S --noconfirm --needed $deps
else
	echo "WARNING: SKIPPING DEPENDENCY INSTALLATION."
fi

echo -e "iterating over '$dots' to find files to copy to home-directory\n"
for f in $(ls -A "$dots"); do

	echo "CHECKING $f:"
	if [[ -f "$dots/$f" ]]; then

		echo -e "'$f' is a file. copying to home-directory.\n"
		cp -r "$HOME/$f" "$backup/"
		rm -rf "$HOME/$f"
		cp -r "$dots/$f" "$HOME/"
	else
		echo -e "skipping: '$f' is a directory.\n"
	fi
done

update .config
update .local/bin
update .local/share

echo "Installation complete."