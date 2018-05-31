#!/bin/bash
LOGPATH=/home/eric/v2ray/log
TIME=`date +"%Y%m%d %H:%M"`
MAXLOGDAY=20

cd $LOGPATH
# split logs
tar -zcf ${TIME}.log.tgz *.log
cat /dev/null > error.log
cat /dev/null > access.log

# delete outdated logs
find $LOGPATH -name "*.tgz" -type f -mtime +${MAXLOGDAY} -exec rm {} \;

