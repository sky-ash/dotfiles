if status is-interactive

    function fish_greeting
        echo Hello friend!
        echo The time is (set_color yellow)(date +%T)(set_color --reset) and this machine is called $hostname

        echo ""
        echo ALIASES:
        echo "    ysu    - `yay -Syyu --noconfirm` (System Update)"
        echo "    yi     - `yay -S --noconfirm` (Install)"
        echo "    vcam   - `uv run ~/Desktop/OpenSeeFace/facetracker.py -c 0 -W 1280 -H 720 --model 3`"
        echo "    gamma  - `hyprctl hyprsunset gamma {g}`"


        
    end

    alias ysu="yay -Syyu --noconfirm"
    alias yi="yay -S --noconfirm"
    alias vcam="uv run ~/Desktop/OpenSeeFace/facetracker.py -c 0 -W 1280 -H 720 --model 3"
    alias gamma="hyprctl hyprsunset gamma"
    
    starship init fish | source
    catnap

end
