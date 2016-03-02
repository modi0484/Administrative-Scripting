#!/bin/bash
# This script will fetch and display only interfacenames and its IP4 addresses
# It will also dispaly default route information

# variables declarations
###########
defaultr=0 # assign default route count to 0
 # Ip Adresses of belonging interfaces
declare -A ipaddress

# creating array of interfaces for ip addresses
declare -a interfaces 

# An array of interfaces name which are found
declare -a intarray 

# create a fuction help for user for command help
##################################################
userhelp(){
  echo "Usage: $0 [-r] [-h] [interface_name]"
  
  echo "options : "
  
  echo " -r option is for default gateway, --route"
  echo " -h option is for help, --help "
}

# create a fuction error-message for send error to stderr
######################################################
errormessage(){
        echo "Usage: $0 [-r] [-h] [interface_name]"
		echo "Argument '$1' not recognized" >&2
}


# MAIN SCRIPT#
#############

#Checking for name of interfaces and default gateway from command line options

while [ $# -gt 0 ]; do
    case "$1" in
    -h|--help )
		userhelp # calling fuction help for user
		exit 0
		;;
    -r|--route )
     if [ $? -ne 0 ]; then
        defaultr=1 # set route to a 1 if asked to display default route
        shift
        else
        errormessage "Invalid Argument"
        exit 2
    fi
        ;;
    *)
     if [ $? -eq 0 ]; then
				interfaces+=("$1") # add unnamed parameters as interface names
			else
				errormessage "mentioned interface is not there" # calling errormessage fuction
				exit 1
			fi
        
        ;;
    esac
    shift
done


# now create an array of interfacename
intarray=(`ifconfig |grep '^[A-Za-z]'|awk '{print $1}'`)


# now assign ip addresses to belonging interface using for loop
for interface in ${intarray[@]}; do
    ipaddress[$interface]=`ifconfig $interface|grep "inet "|sed -e 's/.*inet addr://' -e 's/ .*//'`
done
    
#now fetch default gateway ip address
df=`route -n|grep '^0.0.0.0'|awk '{print $2}'`

# now use all collected information below
if [ ${#interfaces[@]} -gt 0 ]; then # checking of particular interface
    for interface in ${interfaces[@]}; do 
        if [ ${ipaddress[$interface]} ]; then # print only interface information
            echo "$interface : ${ipaddress[$interface]}"
        else # This is for wrong interface information
            errormessage "$interface is not an interface on this host or has no ip address assigned" # calling errormessage fuction
            exit 2
        fi
    done
else
    for interface in ${intarray[@]}; do # print all interface if no particuar interface specified
        echo "$interface : ${ipaddress[$interface]}"
    done
fi

# prints the default route gateway if we were given -r or --route on the command line
[ $defaultr -eq 1 ] && echo "The default route gateway is $gf"