#!/bin/bash
TIME=`date "+%y-%m-%d %H:%M"`
DATE=`date "+%y-%m-%d"`
COLOR_Yellow="\e[033m"
COLOR_RESET="\e[0m"
LOG_PATH="/var/log/v2ray"
MAXLOGDAY=20
SCRIPT_URL="https://install.direct/go.sh"

mkdir ${LOG_PATH}
mkdir ${LOG_PATH}/update/

echo -e "${COLOR_Yellow}${TIME}${COLOR_RESET}" >> ${LOG_PATH}/update//${DATE}.log
bash <(curl -L -s ${SCRIPT_URL}) >> ${LOG_PATH}/update//${DATE}.log
find ${LOG_PATH}/update/ -mtime +${MAXLOGDAY} -name "*.log" -exec rm {} \; # Delete outdate logs

