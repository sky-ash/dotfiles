#!/bin/bash

DOTS=$(pwd)

make_home_dir() {
	mkdir -p $HOME/.config || true
	mkdir -p $HOME/.cache || true
	mkdir -p $HOME/.local/share/fonts || true
	mkdir -p $HOME/.local/share/icons || true
	mkdir -p $HOME/.local/share/wallpaper || true
	mkdir -p $HOME/.local/bin || true
}

back_up_configure() {
	echo "\e[32mbacking up configuration files..."
	mkdir -p $HOME/.dotfiles_backup/.config
	mv -v $HOME/.config/{btop,catnap,cava,dunst,hypr,rofi,waybar,kitty} $HOME/.dotfiles_backup/.config

	echo "\e[32mbacking up local files..."
	mkdir -p $HOME/.dotfiles_backup/.local/share
	mkdir -p $HOME/.dotfiles_backup/.local/bin
	mv -v $HOME/.local/share/{fonts,icons,wallpaper} $HOME/.dotfiles_backup/.local/share
	mv -v $HOME/.local/bin/* $HOME/.dotfiles_backup/.local/bin

	echo "\e[32mbacking up launch-files..."
	mv -v $HOME/{.xinitrc,.bashrc,.bash_profile} $HOME/.dotfiles_backup

	echo "\e[32mbackup finished - you can find your backups at \e[33m$HOME/.dotfiles_backup"
}

echo "\e[32mpreparing directories..."
make_home_dir 2>/dev/null

echo "\e[31mWARNING: Is the dotfiles-folder at \e[33m$(pwd)? \e[32m(y/N)"
read input
if [[ "$input" == "y" ]] || [[ "$input" == "Y" ]]; then
	if [[ -d "$HOME/.dotfiles_backup" ]]; then
		echo ""
		echo "\e[31mWARNING: There seems to already be a backup at \e[33m'$HOME/.dotfiles_backup'"
		echo "\e[33mDo you wanna overwrite it \e[32m(y/N)?"
		read input
		if [[ "$input" == "y" ]] || [[ "$input" == "Y" ]]; then
			rm -rf "$HOME/.dotfiles_backup"
			echo "\e[32mpreparing backup..."
    		back_up_configure
		else
			echo "\e[31mplease delete \e[33m$HOME/.dotfiles_backup \e[31mmanually before installing"
			echo "\e[32minstallation aborted"
			exit
		fi
	else
		back_up_configure
	fi

	# echo "\e[32minstalling fonts..."
	# ln -sv $DOTS/home/.local/fonts $HOME/.local/share/fonts/10_hyprdots_fonts
	# echo "\e[32mdone"

	echo "\e[32minstalling configuration files..."
	cp -r $DOTS/home/.config/{btop,catnap,cava,dunst,hypr,rofi,waybar,kitty} $HOME/.config/
	echo "\e[32mdone"

	echo "\e[32minstalling local files..."
	cp -r $DOTS/home/.local/share/{fonts,icons,wallpaper} $HOME/.local/share/
	cp -r $DOTS/home/.local/bin/* $HOME/.local/bin/
	echo "\e[32mdone"

	echo "\e[32minstalling launch-files..."
	cp -r $DOTS/home/{.xinitrc,.bashrc,.bash_profile} $HOME/
	echo "\e[32mdone"

	echo "\e[32minstallation finished"

else

	echo "\e[32mplease cd into the dotfiles-directory and run this script again"
	echo "\e[32minstallation aborted"
	exit

fi