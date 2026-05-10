#!/bin/bash

USER_ID=$(id -u)
LOGS_FOLDER="/var/log/shell-scripting"
LOGS_FILE="/var/log/shell-scripting/backup.log"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #14 days is default value, if user not provided

R='\e[31m'
G='\e[32m'
Y='\e[33m'
B='\e[34m'
N='\e[0m'

if [ $USER_ID -ne 0 ]; then
   echo -e "$R Please run this script with admin access.. $N" 
fi

mkdir -p $LOGS_FOLDER

log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a "$LOGS_FILE"
}

USAGE(){
    log "$R USAGE: sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS>[default 14 days] $N"
    exit 1
}

if [ $# -lt 2 ]; then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]; then
    echo "$R Source Directory: $SOURCE_DIR doesn't exist $N"
    exit 1
fi

if [ ! -d $DEST_DIR ]; then
    echo "$R Destination Directory: $DEST_DIR doesn't exist $N"
    exit 1
fi

###Find the files

FILES=$(find "$SOURCE_DIR" -name "*.log" -type f -mtime +$DAYS)

log "Backup started"
log "Source Directory: $SOURCE_DIR"
log "Destination Directory: $DEST_DIR"
log "Days: $DAYS"

if [ -z $FILES ]; then
    log "No Files to archive ... $Y SKIPPING $N "
else
    log "Files found to archieve: $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.tar.gz"
    log "Archieve name: $ZIP_FILE_NAME"
    tar -zcvf $ZIP_FILE_NAME $(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

    # Check archieve is success or not
    if [ -f $ZIP_FILE_NAME ]; then
        log "Archeival is ... $G SUCCESS $N"
        while IFS= read -r filepath; do
        # Process each line here
        log "Deleting file: $filepath"
        rm -f $filepath
        log "Deleted file: $filepath"
        done <<< $FILES
    else
        log "Archeival is ... $R FAILURE $N"
        exit 1
    fi
fi




