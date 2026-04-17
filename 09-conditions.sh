#!/bin/bash


NUM=$1

if [ $NUM -gt 30]; then
   echo "Number is greater than 30"
elif [ $NUM -lt 30]; then
   echo "Number is less than 30"
else
   echo "Number is equal to 30"
fi