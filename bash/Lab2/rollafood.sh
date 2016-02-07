#!/bin/bash
#rollafood script

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

echo "index $Var in food has ${food[$Var]} in it"