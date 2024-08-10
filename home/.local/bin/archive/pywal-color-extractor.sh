#!/bin/bash

# extract hex-codes from file

# read file "/home/ashe/.cache/wal/colors"
while IFS= read -r line; do
    lines+=("$line")
done < "/home/ashe/.cache/wal/colors"

# delete directory if it exists
if [[ -d "/home/ashe/.cache/colors" ]]; then
    rm -r "/home/ashe/.cache/colors"
fi

# create directory
mkdir -p "/home/ashe/.cache/colors"

# iterate over all 16 lines and save each line's content in its own file
for ((i=0; i<16; i++)); do
    echo "${lines[i]}" > "/home/ashe/.cache/colors/color$i"
done
