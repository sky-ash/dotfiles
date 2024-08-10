##### my current setup
```
yay -S --needed --noconfirm xdg-desktop-portal-hyprland xorg-server xorg-xinit btop catnap-git cava dunst hyprland hyprlock kitty rofi-lbonn-wayland-only-git swaybg python-pywal sddm-git python-pywalfox polkit-kde-agent archlinux-keyring thunar base base-devel efibootmgr linux linux-firmware grub networkmanager git nano firefox spotify vscodium vscodium-marketplace bluez bluez-utils copyq pipewire-alsa spicetify-cli ttf-jetbrains-mono-nerd ttf-jetbrains-mono papirus-icon-theme gimp signal-desktop vimix-cursors blueberry
```
mullvad-vpn-bin protonmail-desktop obsidian

## dotfile dependencies
```
yay -S --needed xdg-desktop-portal-hyprland xorg-server xorg-xinit bashtop-git catnap-git cava-git dunst hyprland hyprlock kitty rofi swaybg pywal-16-colors sddm-git python-pywalfox polkit-kde-agent gnome-keyring
```

## base
base
base-devel
efibootmgr
linux
linux-firmware
grub
networkmanager

## standard programs
git
nano
firefox
spotify
vscodium
vscodium-marketplace
bluez
blueberry
copyq
nautilus
pipewire-alsa

## ricing
spicetify-cli
nwg-look-bin

#### fonts
ttf-jetbrains-mono-nerd 
otf-monaspace
ttf-monaspace-variable
ttf-jetbrains-mono
otf-operator-mono

#### cursors
vimix-cursors
catppuccin-cursors-macchiato 

#### icons
papirus-folders-catppuccin-git 
papirus-icon-theme

#### themes
catppuccin-gtk-theme-macchiato 
sddm-theme-catppuccin-git 
catppuccin-grub-theme-git

## additional software
mullvad-vpn-bin
protonmail-desktop
obsidian
gimp
signal-desktop
blueberry


# Dotfiles

## Overview
--------------------------------------------
|Left Column        | | Right Column        |
|-------------------|-|---------------------|
| wm                |:| Hyprland            |
| terminal          |:| Kitty               |
| bar               |:| Waybar              |
| notifications     |:| Dunst               |
| file manager      |:| Thunar              |
| launcher          |:| Rofi                |
| browser           |:| Firefox             |
| shell             |:| Bash                |
| music player      |:| Spotify             |
| video player      |:| /                   |
| image viewer      |:| imv                 |
| fetch             |:| catnap              |
| lockscreen        |:| Hyprlock            |
| wallpaper         |:| swaybg              |
| color-theme       |:| PyWal               |
| audio-visualizer  |:| Cava                |
| code-editor       |:| VSCodium            |
| clipboard-manager |:| CopyQ               |
| vpn               |:| Mullvad             |
| cursor            |:| Vimix Cursors       |
| icons             |:| Papirus             |
| font              |:| TTF JetBrains Mono  |


## Installation
To install these dotfiles on your system, follow these steps:

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/dotfiles.git
    ```

2. Change into the dotfiles directory:

    ```bash
    cd dotfiles
    ```

3. Run the installation script:

    ```bash
    ./install.sh
    ```

    This script will create symbolic links for the dotfiles in your home directory.
