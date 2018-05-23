#!/bin/bash
TIME=`date "+%y-%m-%d %H:%M"`
DATE=`date "+%y-%m-%d"`
COLOR_Yellow="\e[033m"
LOG_PATH="/var/log/v2ray"
UPDATE_LOG_PATH="${LOG_PATH}/update"
MAXLOGDAY=20
SCRIPT_URL="https://install.direct/go.sh"

mkdir ${LOG_PATH}
mkdir ${UPDATE_LOG_PATH}

echo -e "${COLOR_Yellow}${TIME}" >> ${LOG_PATH}/${DATE}.log
bash <(curl -L -s ${SCRIPT_URL}) >> ${LOG_PATH}/${DATE}.log
find ${LOG_PATH} -mtime +${MAXLOGDAY} -name "*.log" -exec rm {} \; # Delete outdate logs

