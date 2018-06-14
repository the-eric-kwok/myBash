#!/bin/bash

TOP_LEFT="10:10"
TOP_RIGHT="main_w-overlay_w-10:10"
BUTTOM_LEFT="10:main_h-overlay_h-10"
BUTTOM_RIGHT="main_w-overlay_w-10:main_h-overlay_h-10"
POS=$TOP_LEFT
SIZE=200 #默认大小为长宽200的正方形

# 压制主程序
burn(){
    ffmpeg \
    -i "$VIDEO" \
    -i "$LOGO" \
    -filter_complex \
    "[1]scale=$SIZE:$SIZE[logo];\
    [0][logo]overlay=$POS[taged];\
    [taged]ass=$ASS[sub]" \
    -map [sub] \
    -map 0:a \
    "$OUTPUT"
}

# 文件选择
file_select(){
    VIDEO=`zenity --title="选择视频文件" --text="选择视频文件" --file-selection --filename="$HOME/Videos/"` || exit
    ASS=`zenity --title="选择字幕文件" --text="选择字幕文件" --file-selection --filename="$VIDEO"` || exit
    LOGO=`zenity --title="选择Logo文件" --text="选择Logo文件" --file-selection --filename="$HOME/Pictures/"` || exit
    if [[ -z "$VIDEO" ]] || [[ -z "$ASS" ]] || [[ -z "$LOGO" ]]; then file_select; fi
}

# Logo 位置选择
pos_select(){
    i=`zenity --height=250 --list --radiolist \
        --title="选择Logo位置" --text="选择Logo位置" \
        --column="Select" --column="pos" \
        TRUE "左上" \
        FALSE "右上" \
        FALSE "左下" \
        FALSE "右下"` || exit   
    case "$i" in
        "左上") POS=${TOP_LEFT};;
        "右上") POS=${TOP_RIGHT};;
        "左下") POS=${BUTTOM_LEFT};;
        "右下") POS=${BUTTOM_RIGHT};;
    esac
}

# Logo 大小
logo_size(){
    SIZE=`zenity --scale --title="请输入logo大小" --text="请选择Logo的边长" --value=200 --min-value=100 --max-value=500 --step=50` || exit
}

# 安装依赖
install(){
    sudo apt-get install -y ffmpeg zenity
}

# 判断是否安装必要的依赖
if [[ `dpkg -l | grep 'ffmpeg' | wc -l` -gt 0 ]] || [[ `ffmpeg -version | wc -l` -gt 0 ]] ; then
    FFMPEG=0
fi

if [[ `dpkg -l | grep 'zenity' | wc -l` -gt 0 ]] || [[ `zenity --version | wc -l` -gt 0 ]] ; then
    ZENITY=0
fi

if [[ ! "$FFMPEG" -eq 0 ]] || [[ ! "$ZENITY" -eq 0 ]] ; then
    echo "ffmpeg or zenity not found, installing..."
    #read 
    install
fi

file_select
pos_select
logo_size
OUTPUT=`echo $VIDEO | sed -E 's/(.mkv|.mp4|.tv|.avi|.rmvb|.mov|.qt|.wmv)/.final.mp4/ig'`
burn

