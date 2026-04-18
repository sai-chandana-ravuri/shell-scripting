#!/bin/bash

USER_ID=$(id -u)
LOGS_FOLDER="/var/log/shell-scripting"
LOGS_FILE="/var/log/shell-scripting/$0.log"


if [ $USER_ID -ne 0 ]; then
   echo "Please use admin access to install.." | tee -a $LOGS_FILE
   exit 1
else
   echo "Proceeding with installation.."
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
if [ $1 -eq 0 ]; then
   echo "$2...SUCCESS" | tee -a $LOGS_FILE
else
   echo "$2...FAILURE" | tee -a $LOGS_FILE
   exit 1
fi
}

for package in $@
do
  dnf list installed $package
  if [ $? -ne 0]; then
    echo "$package is not installed, installing now.."
    dnf install $package -y &>> $LOGS_FILE
    VALIDATE $? "Installing $package"
  else
    echo "$package already insatlled, skipping installation."
  fi
done

