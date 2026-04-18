#!/bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
   echo "Please use admin access to install.."
   exit 1
else
   echo "Proceeding with installation.."
fi



VALIDATE(){
if [ $1 -eq 0 ]; then
   echo "$2...SUCCESS"
else
   echo "$2...FAILURE"
   exit 1
fi
}

dnf install nginx -y
VALIDATE $? "Installing nginx"

dnf install mysql -y
VALIDATE $? "Installing Mysql"

dnf install nodejs -y
VALIDATE $? "Installing Nodejs"

