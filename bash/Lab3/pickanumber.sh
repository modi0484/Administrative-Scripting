#!/bin/bash
# this script will ask the user for a random number
#    between one and ten and will keep asking
#    until they get it right

# we need a random number for them to guess between 1 and 10
myNumber=$(($RANDOM % 10 + 1))

guess=0
while [ $guess -ne $myNumber ]; do
    read -p "Pick a number from 1 to 10: " guess
    if [ "$guess" -lt $myNumber ]; then
        echo "It's too small, try again"
    elif [ "$guess" -gt $myNumber ]; then
        echo "It's too big, try again"
    fi
done

echo "You found it... Cheers!!!!"