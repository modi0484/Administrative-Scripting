#!/bin/bash
#This script asks user for two numbers and 
#performs five arithmetc operations with given two numbers

read -p "Give me a first number : " num1
read -p "Give me a second number : " num2

echo "Addition(+) of these two numbers is $((num1 + num2))"
echo "Mupltiplication(*) of these two numbers is $((num1 * num2))"
echo "Difference(-) of these two numbers is $((num1 - num2))"
echo "Dividend(/) of these two numbers is $((num1 / num2))"
echo "Reminder(%) of these two numbers is $((num1 % num2))"