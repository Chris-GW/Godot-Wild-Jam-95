#!/usr/bin/env bash

# Butler manager command
# Uploads directories as builds to matching itch.io channels.
# HTML5  => html5
# Linux  => linux
# Windows => win
# MacOS  => osx

file="upload_destination.txt"

directories=("HTML5" "Linux" "Windows" "MacOS")
channels=("html5" "linux" "win" "osx")

# Create the file if it does not exist
if [[ ! -f "$file" ]]; then
    touch "$file"
fi

# Read the first line
IFS= read -r destination < "$file" || true

# Ask for the destination if the file is empty
if [[ -z "$destination" ]]; then
    echo "Please enter the build destination (username/project-url-after-slash)."
    read -r user_input

    # Save the destination
    printf '%s\n' "$user_input" > "$file"

    echo "Destination saved to $file."
    destination="$user_input"
fi

# Upload each existing build directory
for i in "${!directories[@]}"; do
    dir="${directories[$i]}"
    channel="${channels[$i]}"

    if [[ -d "$dir" ]]; then
        echo "butler push ./$dir/ $destination:$channel"
        butler push "./$dir/" "$destination:$channel"
    else
        echo "Directory '$dir' does not exist."
    fi
done
