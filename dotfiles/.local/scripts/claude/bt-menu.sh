#!/usr/bin/env bash
# TEMP: hardcoded bluetooth + output switcher (headphones / speakers / controller)
# Replaces blueberry + pavucontrol. Meant to be replaced by something better later.

HEADPHONES_MAC="2C:BE:EE:A8:D9:13"
SPEAKERS_MAC="60:F4:3A:65:02:43"
CONTROLLER_MAC="1C:A0:B8:03:08:33"

THEME="$HOME/.config/rofi/rofi.conf"

# ---- helpers ----

is_connected() {
    bluetoothctl info "$1" 2>/dev/null | grep -q 'Connected: yes'
}

# Sink name for a MAC (suffix like .1 can change, so match by prefix)
sink_for() {
    local prefix="bluez_output.${1//:/_}"
    pactl list short sinks | awk -v p="$prefix" 'index($2, p) == 1 { print $2; exit }'
}

is_active() {
    local sink
    sink=$(sink_for "$1")
    [[ -n "$sink" && "$(pactl get-default-sink)" == "$sink" ]]
}

line() { # label mac type(audio|ctrl)
    local label="$1" mac="$2" type="$3" status
    if is_connected "$mac"; then status="● connected   "; else status="○ disconnected"; fi
    local out
    out=$(printf '%-12s %s' "$label" "$status")
    if [[ "$type" == "audio" ]] && is_active "$mac"; then out+="  ▶ ACTIVE"; fi
    echo "$out"
}

notify() { notify-send -e -u "${2:-low}" "Bluetooth" "$1"; }

# ---- actions ----

switch_audio() { # label mac
    local label="$1" mac="$2" sink i

    if ! is_connected "$mac"; then
        notify "Connecting $label..."
        bluetoothctl connect "$mac" >/dev/null 2>&1
    fi

    # wait for the sink to show up (up to ~10 s)
    for i in $(seq 1 20); do
        sink=$(sink_for "$mac")
        [[ -n "$sink" ]] && break
        sleep 0.5
    done

    if [[ -z "$sink" ]]; then
        notify "$label: no audio sink after connect" critical
        exit 1
    fi

    pactl set-default-sink "$sink"
    # move already-playing streams over
    pactl list short sink-inputs | awk '{ print $1 }' | while read -r id; do
        pactl move-sink-input "$id" "$sink"
    done

    notify "Output → $label"
}

toggle_controller() {
    if is_connected "$CONTROLLER_MAC"; then
        bluetoothctl disconnect "$CONTROLLER_MAC" >/dev/null 2>&1
        notify "Controller disconnected"
    else
        notify "Connecting controller..."
        if bluetoothctl connect "$CONTROLLER_MAC" >/dev/null 2>&1; then
            notify "Controller connected"
        else
            notify "Controller: connect failed (is it on?)" critical
            exit 1
        fi
    fi
}

# ---- menu ----

choice=$(
    {
        line "Headphones" "$HEADPHONES_MAC" audio
        line "Speakers"   "$SPEAKERS_MAC"   audio
        line "Controller" "$CONTROLLER_MAC" ctrl
    } | rofi -dmenu -i -theme "$THEME" -mesg "Bluetooth / Output"
)

case "$choice" in
    Headphones*) switch_audio "Headphones" "$HEADPHONES_MAC" ;;
    Speakers*)   switch_audio "Speakers"   "$SPEAKERS_MAC" ;;
    Controller*) toggle_controller ;;
    *)           exit 0 ;;
esac
