#!/bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0]; then
   echo "Please use admin access to install.."
   exit 1
else
   echo "Proceeding with installation.."

P_ID=$?
if [ $P_ID -eq 0]; then
   echo "Installting nginx..."
   dnf install nginx
else
   echo "Installing nginx error.."
   exit 0