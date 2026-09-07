#! /bin/bash

set -e #exits the script when there is an error

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

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
    echo -e "$2 $R FAILURE $N" | tee -a $LOG_FILE
    exit 1
  else 
    echo -e "$2 $G SUCCESS $N " | tee -a $LOG_FILE
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
    echo -e "$PACKAGE already installed $Y skipping $N"
  fi
done