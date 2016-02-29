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
function help {
  echo "Usage: $0 [-r] [-h]"
  
  echo "options : "
  
  echo " -r option is for default gateway, --route"
  echo " -h option is for help, --help "
}

# create a fuction error-message for send error to stderr
function errormessage {
        echo "Usage: $0 [-d level] [-h]"
		echo "Argument '$1' not recognized" >&2
}

#######
#MAIN SCRIPT
############

#Checking for name of interfaces and default gateway in command line

while [ $# -gt 0 ]; do
    case "$1" in
    -h|--help )
		help # call fuction help for user
		exit 0
		;;
    -r|--route )
        defaultr=1 # set route to a 1 if asked to display default route
        ;;
    *)
        interfaces+=("$1") # add unnamed parameters as interface names
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
if [ ${#interfaces[@]} -gt 0 ]; then # use specified interface list if we have one
    for interface in ${interfaces[@]}; do # iterate over interface names requested
        if [ ${ipaddress[$interface]} ]; then # only display info for an interface if we have some
            echo "$interface has address ${ipaddress[$interface]}"
        else # for invalid interface names or interfaces with no address, just let the user know about it
            echo "$interface is not an interface on this host or has no ip address assigned"
        fi
    done
else
    for interface in ${intarray[@]}; do # if no interfaces specified, display them all
        echo "$interface has address ${ipaddress[$interface]}"
    done
fi

# display the default route gateway if we were given -r or --route on the command line
[ $defaultr -eq 1 ] && echo "The default route is through $gf"