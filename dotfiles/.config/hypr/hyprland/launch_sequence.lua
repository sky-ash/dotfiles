--[[    # =========== #
        # UPON LAUNCH #
        # =========== #     ]]

hl.on("hyprland.start", function () 

    -- HYPRLAND STARTUP SEQUENCE
    hl.exec_cmd("copyq --start-server")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("${HOME}/.config/hypr/scripts/xdg-portal-hyprland")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")

    -- AUTOSTART PROGRAMS
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprshade")
    hl.exec_cmd("mullvad connect")                          -- instead of launching mullvad-gui, establish a connection via cli command (turn on or off via waybar)

    -- SET CURSOR THEME 
    hl.exec_cmd("hyprctl setcursor Vimix-cursors 36")       -- (maybe move to "env vars" section?)

end)