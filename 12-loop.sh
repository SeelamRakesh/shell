#! /bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
  echo "Run this script as Root user"
  exit 1
fi

VALIDATE() {
  if [ $1 -ne 0 ]; then
    echo "$2 failure"
    exit 1
 else 
   echo "$2 successful"
  fi
}

for PACKAGE in $@
do
  echo "Installing $PACKAGE"
  dnf install $PACKAGE -y 
  VALIDATE $? "$PACKAGE Installtion"
done