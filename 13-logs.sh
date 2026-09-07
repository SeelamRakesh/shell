#! /bin/bash

LOG_FOLDER="/var/log/shell_script"
LOG_FILE="/var/log/shell_script/$0.log"

USER_ID=$(id -u)

mkdir -p $LOG_FOLDER

if [ $USER_ID -ne 0 ]; then
  echo "Run this script as Root User" | tee -a $LOG_FILE
  exit 1
fi


VALIDATE(){
  if [ $1 -ne 0 ]; then
    echo "$2 FAILURE" | tee -a $LOG_FILE
    exit 1
  else 
    echo "$2 SUCCESS" | tee -a $LOG_FILE
  fi
}

for PACKAGE in $@
do 
  dnf list installed $PACKAGE &>> $LOG_FILE
  if [ $? -ne 0 ]; then
    echo "$PACKAGE not installed installing now"
    dnf install $PACKAGE -y &>> $LOG_FILE
    VALIDATE $? "$PACKAGE installation"
  else 
    echo "$PACKAGE already installed skipping"
  fi
done