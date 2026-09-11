#!/bin/bash

USER_ID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/backup.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

if [ $USER_ID -ne 0 ]; then
   echo "Run this script as Root User"
   exit 1
fi

mkdir -p $LOGS_FOLDER

log(){
   echo -e "$(date "+%d-%m-%Y %H:%M:%S") | $1" | tee -a $LOGS_FILE
}

Usage(){
   echo "USAGE: <SOURCE_DIR> <DEST_DIR> <DAYS>[Default 14days]" | tee -a $LOGS_FILE
   exit 1
}

if [ $# -lt 2 ]; then
  Usage
fi

if [ ! -d $SOURCE_DIR ]; then
   log "$SOURCE_DIR doesn't exist" 
   exit 1
fi

if [ ! -d $DEST_DIR ]; then
   log "$DEST_DIR doesn't exist" 
   exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

log "Backup started"
log "Source Directory: $SOURCE_DIR"
log "Destination Directory: $DEST_DIR"
log "Days: $DAYS"

if [ -z "${FILES}" ]; then
  log "Files not found for backup $Y SKIPPING $N"
else
  log "$G Files found for Archive $N"
  TIME_STAMP=$(date +%F-%H-%M-%S)
  ZIP_FILE_NAME="$DEST_DIR/app_logs-$TIME_STAMP.tar.gz"
  log "Archieve name: $ZIP_FILE_NAME"
  tar -zcvf $ZIP_FILE_NAME $(find "$SOURCE_DIR" -name "*.log" -type f -mtime +$DAYS)
   
  if [ -f $ZIP_FILE_NAME ]; then
     log "Archival $G Success $N"
     while IFS= read -r filepath;
     do
       log "$R Deleting $N file: $filepath"
       rm -f $filepath
       log "$R Deleted $N file: $filepath"
     done <<< $FILES
   else
     log "$R Archival Failure $N"
   fi 
fi