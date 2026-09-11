#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_DIR=/home/ec2-user/app_logs
LOG_FILE=$LOG_DIR/$0.log

if [ ! -d $LOG_DIR ]; then
  echo "Directory doesn't exist"
  exit 1
fi

FILES_TO_DELETE=$(find app_logs -name "*.logs" -mtime +14)

while IFS=read -r filepath ; do 
  echo $filepath
done <<< $FILES_TO_DELETE

