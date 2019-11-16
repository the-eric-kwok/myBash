#!/bin/bash

VIDEO=$1
ASS=$2
LOGO="$HOME/Pictures/IMG_0004.png"
OUTPUT=$(echo $VIDEO | cut -d . -f1).output.mp4

TOP_LEFT="10:10"
TOP_RIGHT="main_w-overlay_w-10:10"
BUTTOM_LEFT="10:main_h-overlay_h-10"
BUTTOM_RIGHT="main_w-overlay_w-10:main_h-overlay_h-10"
POS=$TOP_LEFT
SIZE_L=150
SIZE_W=100

help() {
    echo "Usage: burn.sh <video> <ass sub>"
}

# 压制主程序
burn(){
    ffmpeg \
    -i "$VIDEO" \
    -i "$LOGO" \
    -filter_complex \
    "[1]scale=$SIZE_W:$SIZE_L[logo];\
    [0][logo]overlay=$POS[taged];\
    [taged]ass=$ASS[sub]" \
    -map [sub] \
    -map 0:a \
    "$OUTPUT"
}

which ffmpeg > /dev/null
FFMPEG=$?
if [ "$1" = "-h" -o "$1" = "--help" -o -z "$1" ]; then
    help
elif [ ${FFMPEG} ]; then
    burn
else
    echo "ffmpeg not found, exiting."
    exit 1
fi
