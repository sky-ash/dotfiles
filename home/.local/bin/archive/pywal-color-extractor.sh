#!/bin/bash

# extract hex-codes from file

# read file "~/.cache/wal/colors"
while IFS= read -r line; do
    lines+=("$line")
done < "~/.cache/wal/colors"

# delete directory if it exists
if [[ -d "~/.cache/colors" ]]; then
    rm -r "~/.cache/colors"
fi

# create directory
mkdir -p "~/.cache/colors"

# iterate over all 16 lines and save each line's content in its own file
for ((i=0; i<16; i++)); do
    echo "${lines[i]}" > "~/.cache/colors/color$i"
done
