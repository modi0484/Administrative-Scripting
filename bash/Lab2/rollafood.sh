#!/bin/bash
#This script picks random numbers from 1 to 6 then add them up and result will shows index of food in food array.

# build an array of foods
foods=("pizza" "burger" "frankie" "hotdog" "sandwich" "omlet" "bagels" "beans" "burito" "spaghetti" "gujarati dhokla")

# roll two dice and add them
die1=$(($RANDOM % 6 + 1))
die2=$(($RANDOM % 6 + 1))
diceroll=$(($die1 + $die2))

# display the food from the foods array which has
# our dice roll as the index
index=$(($diceroll -2))
echo "We chose a ${foods[$index]} because we rolled $die1,$die2 for a $diceroll"

########################################
echo "output of my script"
#####################################

food=("pizza" "burger" "frankie" "hotdog" "sandwich" "omlet" "bagels" "beans" "burito" "spaghetti" "gujarati dhokla")

echo " select any random number from 1 to 6: "
Var1=$(shuf -i1-6 -n1)
echo $Var1
echo " select another random number from 1 to 6: "
Var2=$(shuf -i1-6 -n1)
echo $Var2

echo "The addition of these two random numbers is: "
Var=$((Var1 + Var2))
echo $Var

echo "index $Var in food has ${foods~/[$Var]} in it"