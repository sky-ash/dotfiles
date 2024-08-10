#!/bin/bash

# Define file paths
colors_file="/home/ashe/.cache/wal/colors"
cava_config="/home/ashe/.config/cava/config"

# Read colors from file into an array
mapfile -t colors < "$colors_file"

# Cava Config
config_text="""[color]
background = '${colors[0]}'

gradient = 1

gradient_color_1 = '${colors[1]}'
gradient_color_2 = '${colors[2]}'
gradient_color_3 = '${colors[3]}'
gradient_color_4 = '${colors[4]}'
gradient_color_5 = '${colors[5]}'
gradient_color_6 = '${colors[6]}'
gradient_color_7 = '${colors[7]}'
gradient_color_8 = '${colors[8]}'
"""

# Write the cava config to file
echo "$config_text" > "$cava_config"
