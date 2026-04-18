#!/bin/bash

set -e
trap 'echo "There is an error in $LINENO, Command: $BASH_COMMAND"' ERR
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

for package in $@
do
  dnf list installed $package &>>$LOGS_FILE
  if [ $? -ne 0 ]; then
    echo "$package is not installed, installing now.."
    dnf install $package -y &>>$LOGS_FILE
  else
    echo "$package already installed, skipping installation."
  fi
done

