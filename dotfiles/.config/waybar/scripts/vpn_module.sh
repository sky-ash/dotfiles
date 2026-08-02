#!/bin/bash

get_status() {
    mullvad status 2>/dev/null | grep -q "Connected"
}

toggle() {
    if get_status; then
        mullvad disconnect
    else
        mullvad connect
    fi
}

report() {
    if get_status; then
        echo '{"text": "󰌆 VPN", "class": "connected"}'
    else
        echo '{"text": "󰌊 VPN", "class": "disconnected"}'
    fi
}

case "$1" in
    --toggle) toggle ;;
    *) report ;;
esac