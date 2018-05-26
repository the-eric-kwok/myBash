#!/bin/bash
help(){
    echo "Usage: burn_ass.sh <video> <ass sub> <output>"
}

if [ "$1" = "-h" -o "$1" = "--help" -o -z "$1" ]
    then help
    else ffmpeg -i "$1" -vf "ass=$2" "$3"
fi
