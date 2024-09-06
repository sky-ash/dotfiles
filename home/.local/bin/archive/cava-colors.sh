#!/bin/bash

# colors path
cfg="~/.config/cava/config"
colors="~/.cache/colors/"

# Loop through each file in the colors
for file in "$colors"*
do
    # Read the hexcode from the file
    hexcode=$(cat "$file")

    # Add the hexcode to the array
    hexcodes+=("$hexcode")
done

text="""
[color]
background = '${hexcodes[0]}'

gradient = 1

gradient_color_1 = '${hexcodes[1]}'
gradient_color_2 = '${hexcodes[2]}'
gradient_color_3 = '${hexcodes[3]}'
gradient_color_4 = '${hexcodes[4]}'
gradient_color_5 = '${hexcodes[5]}'
gradient_color_6 = '${hexcodes[6]}'
gradient_color_7 = '${hexcodes[7]}'
gradient_color_8 = '${hexcodes[8]}'
"""


echo "$text" > "$cfg"