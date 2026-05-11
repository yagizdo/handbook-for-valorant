#!/bin/bash

convertToWebp(){
    path="$1"
    # Skip app_icon.png
    if [[ $path == *"app_icon.png"* ]]; then
        return
    fi

    # Skip splash folder
    if [[ $path == *"splash"* ]]; then
        return
    fi
    
    printf "Converting $path to webp\n"
    cwebp -q 100 "$path" -o "${path%.*}.webp"
    rm "$path"
}

export -f convertToWebp

# png
find ./module/gen/assets -name '*.png' | parallel convertToWebp

# jpg
find ./module/gen/assets -name '*.jpg' | parallel convertToWebp

# jpeg
find ./module/gen/assets -name '*.jpeg' | parallel convertToWebp
