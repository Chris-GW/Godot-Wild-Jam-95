#!/usr/bin/env bash

# Butler manager command
# Uploads directories as builds to matching itch.io channels.
# HTML5  => html5
# Linux  => linux
# Windows => win
# MacOS  => osx

destination="chris-gw/discontinued"
channels=("html5" "linux" "win" "osx")
directories=("HTML5" "Linux" "Windows" "MacOS")


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
