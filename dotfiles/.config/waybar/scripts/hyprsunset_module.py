#!/usr/bin/env python3

from __future__ import annotations


# --- files ----------------------------------

import os
from pathlib import Path
CACHE_DIR = Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache"))
RUNTIME_DIR = Path(os.environ.get("XDG_RUNTIME_DIR", "/tmp"))

STATE_FILE = CACHE_DIR / "nightlight.conf"
ON_FLAG = RUNTIME_DIR / "nightlight.on"


# --- temp & gamma -------------------------------------------------------

ICONS = {
    "off": "\U000F0594",
    "temp": "\U000F05A8",
    "gamma": "\U000F00DE"
}

from dataclasses import dataclass
@dataclass(frozen=True)
class Range:
    low: int
    high: int
    step: int
    default: int
    icon: str
    unit: str
    mode: str

    def clamp(self, value: int) -> int:
        return max(self.low, min(self.high, value))

T = Range(low=2000, high=5500, 
          step=250, default=3500, 
          icon=ICONS["temp"], unit="K", mode="temp")

G = Range(low=20, high=100, 
          step=10, default=70, 
          icon=ICONS["gamma"], unit="%", mode="gamma")


# --- state --------------------------------------------------------------

import json
@dataclass
class State:
    temp: int = T.default
    gamma: int = G.default
    mode: str = T.mode

    @classmethod
    def load(cls) -> State:
        try:
            saved = json.loads(STATE_FILE.read_text())
        except:
            return cls()

        mode_saved = saved.get("mode")
        mode = f"{mode_saved}" if mode_saved in [T.mode, G.mode] else T.mode

        temp_saved = int(saved.get("temp", T.default))
        gamma_saved = int(saved.get("gamma", G.default))

        return cls(
            temp=T.clamp(temp_saved),
            gamma=G.clamp(gamma_saved),
            mode=mode,
        )

    def change(self, direction: int) -> None:
        """Nudge whichever value the active mode controls by one step."""
        if self.mode == T.mode:
            self.temp = T.clamp(self.temp + direction * T.step)
        else:
            self.gamma = G.clamp(self.gamma + direction * G.step)
            
    def save(self) -> None:
        STATE_FILE.parent.mkdir(parents=True, exist_ok=True)
        STATE_FILE.write_text(json.dumps({
            "temp": self.temp, 
            "gamma": self.gamma, 
            "mode": self.mode
        }))

    @property
    def icon(self) -> str:
        return T.icon if self.mode == T.mode else G.icon

    @property
    def active_value(self) -> str:
        return f"{self.temp}{T.unit}" if self.mode == T.mode else f"{self.gamma}{G.unit}"


# --- on off state and toggle --------------------------------------

def is_on() -> bool:
    return ON_FLAG.exists()

def toggle(turn_on: bool = False) -> None:
    if turn_on or not is_on():
        ON_FLAG.touch()
    elif is_on():
        ON_FLAG.unlink(missing_ok=True)


# --- lock --------------------------------------

LOCK_FILE = RUNTIME_DIR / "nightlight.lock"

import fcntl
import sys
import time
from contextlib import contextmanager
@contextmanager
def locked(timeout: float = 3):
    """(this function is ai-generated code)
    Hold a file lock so concurrent invocations can't race on the state file.

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


# --- refresh waybar ----------------------------------

WAYBAR_SIGNAL = 8  # must match "signal" in custom.jsonc

import subprocess
def refresh_waybar() -> None:
    subprocess.run(["pkill", f"-RTMIN+{WAYBAR_SIGNAL}", "waybar"])


# --- talking to hyprsunset --------------------------------------

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


# --- json output --------------------------------------

def report(state: State) -> str:
    on = is_on()
    text = f"{T.icon} {state.temp}{T.unit}" if on and state.mode == T.mode else \
           f"{G.icon} {state.gamma}{G.unit}" if on else ICONS["off"]

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


# --- MAIN / SCRIPT EXEC --------------------------------------

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
        state.mode = G.mode if state.mode == T.mode else T.mode
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
