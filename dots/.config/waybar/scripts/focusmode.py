import os
import subprocess
import sys
import json

class hyprConfig():
    def __init__(self):
        self.variables_path = self.set_var_dir()
        self.general = General()
        self.decoration = Decoration()

    def set_var_dir(self):
        # get the path to the hyprland variables folder
        path = os.path.expanduser("~/.config/hypr/variables/")
        if not os.path.exists(path):
            os.makedirs(path)
        return path
    
    def write_general_config(self):
        # write the config to hyprland
        path = self.variables_path
        filename = "general.conf"
        with open(os.path.join(path, filename), "w") as f:
            f.write(self.general.__format__())

    def write_decoration_config(self):

        path = self.variables_path
        filename = "decoration.conf"
        with open(os.path.join(path, filename), "w") as f:
            f.write(self.decoration.__format__())
            

    def focusMode(self):
        # focus mode means: smaller gaps, smaller borders etc.
        self.general.gaps_in = 0
        self.general.gaps_out = 0
        self.general.border_size = 0
        self.general.col_active_border = "0xffffffff"
        self.general.col_inactive_border = "0x22ffffff"

        self.decoration.rounding = 0
        self.decoration.active_opacity = 1
        self.decoration.inactive_opacity = 1
        self.decoration.fullscreen_opacity = 1

    def __dict__(self):
        return {
            "general": self.general.__dict__(),
            "decoration": self.decoration.__dict__()
        }





class General():
    def __init__(self):
        self.gaps_in = 17
        self.gaps_out = 21
        self.border_size = 9
        self.col_active_border = "0x22dddddd"
        self.col_inactive_border = "0x22777777"
        self.no_border_on_floating = False

    def __format__(self):
        lines = [
            f"gaps_in = {self.gaps_in}",
            f"gaps_out = {self.gaps_out}",
            f"border_size = {self.border_size}",
            f"col_active_border = {self.col_active_border}",
            f"col_inactive_border = {self.col_inactive_border}",
            f"no_border_on_floating = {self.no_border_on_floating}"
        ]

        # indent the lines
        lines = [f"    {line}" for line in lines]
        firstLine = "general {"
        lastLine = "}"
        lines = [firstLine] + lines + [lastLine]
        return "\n".join(lines)
    
    def __dict__(self):
        return {
            "gaps_in": self.gaps_in,
            "gaps_out": self.gaps_out,
            "border_size": self.border_size,
            "col_active_border": self.col_active_border,
            "col_inactive_border": self.col_inactive_border,
            "no_border_on_floating": self.no_border_on_floating
        }

        
class Decoration():
    def __init__(self):
        self.rounding = 0
        self.active_opacity = 1
        self.inactive_opacity = 0.98
        self.fullscreen_opacity = 1
        self.blur = Blur()
        self.shadow = Shadow()

    def __format__(self):
        lines = [
            f"rounding = {self.rounding}",
            f"active_opacity = {self.active_opacity}",
            f"inactive_opacity = {self.inactive_opacity}",
            f"fullscreen_opacity = {self.fullscreen_opacity}",
            f"{self.blur.__format__()}",
            f"{self.shadow.__format__()}"
        ]

        # indent the lines
        lines = [f"    {line}" for line in lines]
        firstLine = "decoration {"
        lastLine = "}"
        lines = [firstLine] + lines + [lastLine]
        return "\n".join(lines)
    
    def __dict__(self):
        return {
            "rounding": self.rounding,
            "active_opacity": self.active_opacity,
            "inactive_opacity": self.inactive_opacity,
            "fullscreen_opacity": self.fullscreen_opacity,
            "blur": self.blur.__dict__(),
            "shadow": self.shadow.__dict__()
        }
            

class Blur():
    def __init__(self):
        self.enabled = True
        self.enabled = True
        self.size = 2
        self.passes = 2
        self.new_optimizations = True
        self.ignore_opacity = False

    def __format__(self):
        lines = [
            f"enabled = {self.enabled}",
            f"size = {self.size}",
            f"passes = {self.passes}",
            f"new_optimizations = {self.new_optimizations}",
            f"ignore_opacity = {self.ignore_opacity}"
        ]

        # indent the lines
        lines = [f"        {line}" for line in lines]
        firstLine = "blur {"
        lastLine = "    }"
        lines = [firstLine] + lines + [lastLine]
        return "\n".join(lines)        


class Shadow():
    def __init__(self):
        self.enabled = True
        self.ignore_window = True
        self.offset = "0 0"
        self.range = 9
        self.render_power = 3
        self.color = "0xff000000"

    def __format__(self):
        lines = [
            f"enabled = {self.enabled}",
            f"ignore_window = {self.ignore_window}",
            f"offset = {self.offset}",
            f"range = {self.range}",
            f"render_power = {self.render_power}",
            f"color = {self.color}"
        ]

        # indent the lines
        lines = [f"        {line}" for line in lines]
        firstLine = "shadow {"
        lastLine = "    }"
        lines = [firstLine] + lines + [lastLine]
        return "\n".join(lines)
    