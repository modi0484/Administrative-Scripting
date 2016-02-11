#!/bin/bash
#This script asks user for two numbers and 
#performs five arithmetc operations with given two numbers

read -p "Enter a number " firstnum
read -p "Enter a second number " secondnum

total=$((firstnum + secondnum))
echo "$firstnum + $secondnum equals $total"
total=$((firstnum - secondnum))
echo "$firstnum - $secondnum equals $total"
total=$((firstnum * secondnum))
echo "$firstnum * $secondnum equals $total"
total=$((firstnum / secondnum))
echo "$firstnum / $secondnum equals $total"
remainder=$((firstnum % secondnum))
echo "$firstnum modulus $secondnum equals $remainder"