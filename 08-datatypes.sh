#!/bin/bash

NUM1=10
NUM2=20
NUM3=Chandana
FRUITS=("Apple","Banana","Carrot")
TOTAL=$(($NUM1+$NUM2))
TOTAL1=$(($NUM1+$NUM2+$NUM3))
echo "Total sum is $TOTAL"
echo "Total sum is $TOTAL1"
echo "Fruits: $FRUITS[@]"
echo "First fruit is: $FRUITS[0]"
echo "First fruit is: $FRUITS[1]"