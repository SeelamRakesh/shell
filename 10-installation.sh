#! /bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
  echo "Run the script as Root user"
  exit 1
fi

echo "Installing Nginx"
dnf install nginx -y

if [ $? -eq 0 ]; then
  echo "Nginx installation successful"
else
  echo "Nginx installation failure"
fi

