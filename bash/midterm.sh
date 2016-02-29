#!/bin/bash

# This script will ask user for any number

# user get number with multiplying by 6

declare -A num
read -p "enter any number : " num
Answer=$((num * 6))
echo $Answer

myhash=([key1]="data1" [key2]="data2")