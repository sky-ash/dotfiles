#!/usr/bin/env python3
from __future__ import annotations

# Imports, Constants, Dataclasses
import os
from pathlib import Path

CACHE_DIR = Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache"))
RUNTIME_DIR = Path(os.environ.get("XDG_RUNTIME_DIR", "/tmp"))
STATE_FILE = CACHE_DIR / "nightlight.conf"
ON_FLAG = RUNTIME_DIR / "nightlight.on"

WAYBAR_SIGNAL = 8  # must match "signal" in custom.jsonc

def refresh_waybar() -> None:
    subprocess.run(["pkill", f"-RTMIN+{WAYBAR_SIGNAL}", "waybar"])

ICON_OFF = "\U000F0594"       #  moon
#ICON_WARMTH = "\U000F05A8"    #  sun
#ICON_DARKNESS = "\U000F00DE"  #  brightness
# ICONS = {Mode.WARMTH: "\U000F05A8", Mode.DARKNESS: "\U000F00DE"}  #  sun,  brightness

import json
import os
import subprocess
import sys
import time
from dataclasses import dataclass

# --- temp & gamma -------------------------------------------------------

@dataclass(frozen=True)
class Range:
    lo: int
    hi: int
    step: int
    default: int
    icon: str
    unit: str

    def clamp(self, value: int) -> int:
        return max(self.lo, min(self.hi, value))

TEMP = Range(lo=2000, hi=5500, step=250, default=3500, icon="\U000F05A8", unit="K")
GAMMA = Range(lo=20, hi=100, step=10, default=70, icon="\U000F00DE", unit="%")

# --- state --------------------------------------------------------------


K = "warmth"
D = "darkness"

@dataclass
class State:
    temp: int = TEMP.default
    gamma: int = GAMMA.default
    mode: str = K

    @classmethod
    def load(cls) -> State:
        try:
            saved = json.loads(STATE_FILE.read_text())
        except:
            return cls()

        mode_saved = saved.get("mode")
        mode = f"{mode_saved}" if mode_saved in [K, D] else K

        temp_saved = int(saved.get("temp", TEMP.default))
        gamma_saved = int(saved.get("gamma", GAMMA.default))

        return cls(
            temp=TEMP.clamp(temp_saved),
            gamma=GAMMA.clamp(gamma_saved),
            mode=mode,
        )

    def change(self, direction: int) -> None:
        """Nudge whichever value the active mode controls by one step."""
        if self.mode == K:
            self.temp = TEMP.clamp(self.temp + direction * TEMP.step)
        else:
            self.gamma = GAMMA.clamp(self.gamma + direction * GAMMA.step)
            
    def save(self) -> None:
        STATE_FILE.parent.mkdir(parents=True, exist_ok=True)
        STATE_FILE.write_text(json.dumps({
            "temp": self.temp, 
            "gamma": self.gamma, 
            "mode": self.mode
        }))

    @property
    def icon(self) -> str:
        return TEMP.icon if self.mode == K else GAMMA.icon

    @property
    def active_value(self) -> str:
        return f"{self.temp}{TEMP.unit}" if self.mode == K else f"{self.gamma}{GAMMA.unit}"




# --- on off state and toggle --------------------------------------



def is_on() -> bool:
    return ON_FLAG.exists()

def toggle(turn_on: bool = False) -> None:
    if turn_on or not is_on():
        ON_FLAG.touch()
    elif is_on():
        ON_FLAG.unlink(missing_ok=True)

LOCK_FILE = RUNTIME_DIR / "nightlight.lock"

from contextlib import contextmanager
@contextmanager
def locked(timeout: float = 3):
    """Hold a file lock so concurrent invocations can't race on the state file.

    Fast scrolling fires many instances of this script at once; each one still
    reads state, updates it and writes it back, so without a lock two
    overlapping runs could both read the same starting value and one update
    would get lost. This just forces that read-update-write to happen one
    instance at a time.
    """
    LOCK_FILE.parent.mkdir(parents=True, exist_ok=True)
    with open(LOCK_FILE, "w") as lock_file:
        deadline = time.monotonic() + timeout
        while True:
            try:
                fcntl.flock(lock_file, fcntl.LOCK_EX | fcntl.LOCK_NB)
                break
            except BlockingIOError:
                if time.monotonic() >= deadline:
                    sys.exit(1)  # never wait forever
                time.sleep(0.05)
        yield




# --- talking to hyprsunset / waybar --------------------------------------

def run_hyprctl(*args: str) -> None:
    subprocess.run(["hyprctl", "hyprsunset", *args], stdout=subprocess.DEVNULL)


def apply(state: State) -> None:
    """Push the current state to the running hyprsunset daemon."""
    if is_on():
        run_hyprctl("temperature", str(state.temp))
        run_hyprctl("gamma", str(state.gamma))
    else:
        run_hyprctl("identity")
        run_hyprctl("gamma", "100")


# neutral output / json (render for tooltip and icons)

"""
def render(state: State) -> str:
    on = is_on()
    text = f"{state.icon} {state.active_value}" if on else ICON_OFF
    return json.dumps({"text": text, "class": "on" if on else "off"}, ensure_ascii=False)
"""



def report(state: State) -> str:
    on = is_on()
    text = f"{TEMP.icon} {state.temp}{TEMP.unit}" if on and state.mode == K else \
           f"{GAMMA.icon} {state.gamma}{GAMMA.unit}" if on else ICON_OFF

    # tooltip text (optional)
    tooltip = "\n".join((
        f"Night light: {'on' if on else 'off'}",
        f"Warmth: {state.temp}K",
        f"Darkness: {state.gamma}%",
        "",
        "Click: toggle",
        f"Scroll: {state.mode} (right-click to switch)",
    ))

    return json.dumps({"text": text, "tooltip": tooltip, "class": "on" if on else "off"}, ensure_ascii=False)




# SCRIPT EXECUTE

import argparse
def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    action = parser.add_mutually_exclusive_group()
    action.add_argument("--toggle", action="store_true", help="night light on/off")
    action.add_argument("--up", action="store_true", help="increase the active value (turns on if off)")
    action.add_argument("--down", action="store_true", help="decrease the active value (turns on if off)")
    action.add_argument("--switch-mode", action="store_true", help="scroll controls warmth <-> darkness")
    return parser.parse_args()

def main() -> None:
    args = parse_args()
    if not (args.toggle or args.up or args.down or args.switch_mode):
        print(report(State.load()))
        return

    state = State.load()

    if args.switch_mode:
        state.mode = D if state.mode == K else K
        state.save()
        refresh_waybar()
        return

    if args.toggle:
        toggle()
    else:
        state.change(+1 if args.up else -1)
        toggle(turn_on=True)
        state.save()

    apply(state)
    refresh_waybar()

if __name__ == "__main__":
    main()











