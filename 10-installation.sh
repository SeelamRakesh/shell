#! /bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
   echo "run the script as root user"
   exit 1
fi

echo "Installing Nginx"
dnf install nginx -y

if [ $? -ne 0 ]; then
  echo "Nginx installation failure"
  exit 1
else
  echo "Nginx installed successfully"
fi