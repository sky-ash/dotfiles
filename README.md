# dotfiles

> [!WARNING]  
> *[copyconfig.sh](dotfiles/.config/hypr/scripts/copyconfig.sh)* (**CTRL + ALT + U**) only works if this dotfiles repository sits in `~/Desktop/`. 
> The source path is hardcoded into the script.

<a name="install-warning"></a>
> [!CAUTION]
> **[install](install.sh)** & **[systemsetup](systemsetup.sh)** ARE OUTDATED. 
> USE WITH CAUTION

## disclaimer
> these are my personal dotfiles. 

if you are thinking about installing them, keep in mind:
- they are not (yet) designed to be installed on other systems. 
- they are designed along my personal preferences, including things like my directory-structure, monitor config, aur packages etc. 
- they are always a work in progress, constantly evolving and rarely error-free. 

> [!NOTE]
> you are welcome to use my configs or scripts as a reference for your own :)

## ideas & to-do

### planned utilits 
- [ ] sound output device switcher
- [x] ~~volume slider~~ on-scroll volume change
- [ ] bluetooth
    - [ ] on/off switch
    - [ ] connect/disconnect known devices
    - [ ] scan for new devices 
- [ ] SwayNC
    - [ ] fit height to screen
    - [ ] slide-in animation
- [ ] wallpaper-selector (instead of just iteration)
- [ ] waybar
    - [x] fix workspace-permanence for hyprland workspaces
    - [x] weather module
    - [ ] active keyboard layout display (& switcher)
    - [ ] power-menu (shutdown, reboot, logout) 
        - [ ] set up a proper utility like wlogout
    - [ ] brightness slider (dim screen)
    - [ ] blue light filter switch
        - [ ] & intensity slider?
    - [ ] spotify/media module
        - [ ] currently playing
        - [ ] pause/prev/next

### needs aesthetics upgrade
- [ ] hyprlock
- [ ] session manager (ly)
    - [ ] adjust for ultrawide monitor (renders in top-left 1920x1080)

### repository maintenance
- [x] update [README.md](README.md)
    - [ ] add images
- [ ] revamp [install.sh](install.sh)

## features
- trying to adhere to a minimalistic aesthetic
- shortcut to iterate through wallpapers and automatically update color-scheme using pywal
    - includes custom scripts to automatically update colors for **cava** and **btop** without restarting the terminal
    - third-party extensions to use pywal color-scheme in
        - firefox: [Pywalfox](https://addons.mozilla.org/en-US/firefox/addon/pywalfox/)
        - vscode/vscodium: [Wal Theme](https://marketplace.visualstudio.com/items?itemName=dlasagno.wal-theme) 

### keyboard shortcuts

| Shortcut              | Utility/Program                   |
|-----------------------|-----------------------------------|
| SUPER + Space         | app-launcher (rofi)               |
| SUPER + Q             | terminal (kitty)                  |
| SUPER + E             | file manager (nautilus)           |
| SUPER + W             | browser (firefox)                 |
| SUPER + C             | vscode                            |
| SUPER + S             | kill active window                |
| ALT + Space           | toggle floating/tiling            |
| CTRL + Space          | screenshot selected area          |
| SUPER + ALT + Space   | cycle keyboard layout             |
| CTRL + ALT + N        | next wallpaper + color update     |
| CTRL + ALT + U        | update .config (`copyconfig.sh`)  |

## installation

> [!CAUTION]
> RUN AT OWN RISK, [SEE ABOVE](#install-warning)

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

### alternative install for current-state compatibility

```bash
mkdir -p ~/Desktop/
git clone https://github.com/sky-ash/dotfiles.git ~/Desktop/
cd ~/.config/
mkdir -p btop catnap cava era hypr kitty nwg-look rofi swaync waybar
~/Desktop/dotfiles/dotfiles/.config/hypr/scripts/copyconfig.sh
```
