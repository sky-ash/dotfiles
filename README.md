# sky's dotfiles

## disclaimer
> these are my personal dotfiles. 

if you are thinking about installing them, keep in mind:
- they are not designed to be installed on other systems. 
- they are designed along my personal preferences, including things like my directory-structure, monitor config, aur packages etc. 
- they are always a work in progress, constantly evolving and rarely error-free. 
- (if you clone this directory, it will include a large amount of wallpapers which i was too lazy to backup elsewhere. sorry not sorry)
> you are welcome to use my configs or scripts as a reference for your own :)

## features
- trying to adhere to a minimalistic aesthetic
- shortcut to iterate through wallpapers and automatically update color-scheme using pywal
 - also update firefox colors with pywalfox
 - (vscodium colors through marketplace extension)
- scripts to automatically update configs with pywal colors for: 
 - cava
 - btop
- translucent waybar colors
- shortcut to update .config folder from changes in dotfiles folder (for development)

### shortcuts
| Utility | Shortcut |
|-|-|
| menu (rofi) | SUPER + Space |
| terminal (kitty) | SUPER + Q |
| file manager (thunar) | SUPER + E |
| firefox | SUPER + W |
| vscodium | SUPER + C |
| sync dotfiles-folder to system | CTRL + ALT + N |
| next wallpaper + color-update | CTRL + ALT + U |


### overview
--------------------------------------------
| | | |
|-------------------|-|---------------------|
| wm                |:| hyprland            |
| terminal          |:| kitty               |
| bar               |:| waybar              |
| notifications     |:| dunst               |
| file manager      |:| thunar              |
| launcher          |:| rofi                |
| browser           |:| firefox             |
| shell             |:| bash                |
| music player      |:| spotify             |
| video player      |:| mpv                 |
| image viewer      |:| imv                 |
| fetch             |:| catnap              |
| lockscreen        |:| hyprlock            |
| wallpaper         |:| swaybg              |
| color-theme       |:| pywal               |
| audio-visualizer  |:| cava                |
| code-editor       |:| vscodium            |
| clipboard-manager |:| copyq               |
| vpn               |:| mullvad             |
| cursor-theme      |:| vimix               |
| icon-theme        |:| papirus             |
| font              |:| jetbrains mono      |


## installation

1. clone the repository:

    ```bash
    git clone https://github.com/sky-ash/dotfiles.git
    ```

2. change into the dotfiles directory:

    ```bash
    cd dotfiles
    ```

3. run the installation script:

    ```bash
    ./install.sh
    ```