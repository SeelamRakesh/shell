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

Usage(){
   echo "USAGE: <SOURCE_DIR> <DEST_DIR> <DAYS>[Default 14days]"
   exit 1
}

if [ $# -lt 2 ]; then
  Usage
fi

if [ ! -d $SOURCE_DIR ]; then
   echo "$SOURCE_DIR doesn't exist"
   exit 1
fi

if [ ! -d $DEST_DIR ]; then
   echo "$DEST_DIR doesn't exist"
   exit 1
fi