#!/bin/bash


R='\e[31m'
G='\e[32m'
Y='\e[33m'
B='\e[34m'
N='\e[0m'

LOGS_DIR=/home/ec2-user/app-logs
LOGS_FILE="$LOGS_DIR/$0.log"

if [ ! -d $LOGS_DIR ]; then
    echo -e "Directory doesn't exist"
    exit 1
fi

FILES_TO_DELETE=$(find $LOGS_DIR -name "*.log" -mtime +14)

while IFS= read -r filepath; do
    echo "Deleting $filepath"
    echo "$FILES_TO_DELETE"
    rm -f $filepath
    echo "Deleted $filepath"
done <<< "$FILES_TO_DELETE"
