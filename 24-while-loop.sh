#!/bin/bash

count=1

while IFS=read -r line; do
    echo "$line"
done < 21-script-1.sh