#!/bin/bash

# Akash Modi (200301572)

# This script will ask user a number between 1 to 5(default count will be 2)
# It will aslo ask user for count of number of dice as well as number of sides
# And finally It will print the result of rolling dice to the user



####### Variables Declaration ##########
#################################################

# By deafult Variable $dicecount=2
# By default Variable $dicesides=6
# At the beginning the toltal rolls will be 0
total=0



######### create a function userhelp for user for command help ############
##################################################
userhelp () {
  echo "Usage: $0 [-c] [-s] [-h]"
 
  echo "Options: "
    echo " -c option is for dicecount value, --dicecount [default is 2]"
    echo " -s option is for dicesides value, --dicesides [default is 6]"
    echo " -h option is for help, --help "
}




########### MAIN SCRIPT ##############
##############################################

# here is while loop for checking the dicecount, dicesides from commaand line option and also dispay command help option

while [ $# -gt 0 ]; do
	case "$1" in
	-h|--help )
		userhelp # call fuction help for user
		exit 0
		;;
    -c )
        if [[ "$2" =~ ^[1-5]$ ]]; then
            dicecount=$2
            shift
        else
            userhelp "Dear user,  Dice number should be between 1 to 5 !!!!"
            exit 2
        fi
        ;;
    -s )
        if [[ "$2" =~ ^[1-9][0-9]*$ ]]; then
            if [ "$2" -ge 4 -a "$2" -le 20 ]; then
                dicesides=$2
                shift
            else
                userhelp "Dear user, Dice sides should be between 4 to 20 !!!!!"
                exit 2
            fi
        fi
        ;;
    esac
    shift
done



# now mention two if loops for asking user to dicecount and dicesides

# for dice count
if [ -z "$dicecount" ]; then
    
    read -p "Please enter number of dice count from 1 to 5. if you press enter then dcript will take default count 2:  " numberofdices

    # actual checking of user's input
    if [[ "$numberofdices" =~ ^[1-5]$ ]]; then
        dicecount=$numberofdices
    else
        dicecount=2
        echo "No problem I will take default value then"
    fi
fi

if [ -z "$dicesides" ]; then
   
    read -p "Please enter number of dice sides from 4 to 20. if you press enter then script will take default count 6:  " numberofsides

    # actual checking of user's input
    if [[ "$numberofsides" =~ ^[1-9][0-9]*$ ]]; then
        if [ $numberofsides -ge 4 -a $numberofsides -le 20 ]; then
            dicesides=$numberofsides
        else
            dicesides=6
            echo "your number for dice sides is either less than 4 or greater then 20"
        fi
    else
        dicesides=6
        echo "Using 6-sided dice, since you are being difficult"
    fi
fi


# final while loop for rolling the dice and summerization

while [ $dicecount -gt 0 ]; do

    
    roll=$(( $RANDOM % $dicesides +1 )) # the roll range is based on the number of sides
    
    total=$(( $total + $roll )) # add recent rolling to total rolling
    
    # give the user feedback about the current roll
    echo "Rolled $roll" # tell user regarding recent roll
    
    # the loop will end when the count of dice to roll reaches zero
    ((dicecount--))
done

# done rolling, display the sum of the rolls
echo "Dear user, You rolled a total of $total ... cheers!!!!"