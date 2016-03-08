#!/bin/bash

# Akash Modi (200301572)

# This script demonstrates how to trap signals and handle them using functions


####### Variables Declaration ##########
#################################################




############ create a fuction userhelp for user for command help ###############
##################################################
userhelp(){
  echo "Usage: $0 [-i] [-h] [secs]"
  
  echo "options : "
  
  echo " -i option is for interval, --interval"
  echo " -h option is for help, --help "
}

############ create a fuction errormessage for send error to stderr #############
######################################################
errormessage(){
    echo "Usage: $0 [-i] [-h] [secs]"
		echo "Invalid Argument : $1" >&2
}

# Normally traps catch signals and do something useful or necessary with them
# These functions are for use with traps for signals we want to catch
# Quit if we get SIGQUIT, but let the user know why we are exiting
# Squawk if we get SIGHUP
# If we get SIGINT, we reset the counter to where it started
sigquit(){
  logger -t `basename "$0"` -i -p user.notice -s “ABORTING!!!!!”
  echo "I am aborting because i received SIGQUIT signal... something was going wrong from your side "
  echo " see you soon ....."
  userhelp
  core 3
}

sigint(){
  echo "---------- It's all good. Keep trying-------------"
  userhelp
}

# trap the signals we care about and use them to invoke the functions above
trap sigint SIGINT
trap sigquit SIGQUIT

#### Main Script #########
##############################

# Process command line parameters

while [ $# -gt 0 ]; do
	case "$1" in
	-h|--help )
		userhelp # call fuction help for user
		exit 0
		;;
    -c| --count )
        
       ;;
       
     *)
       errormessage "Argument not matched"
       exit 2
       
    esac
done


# display what is left in our count

echo $count
# sleep until it is time for the next display
sleep 99

# end the script when the count reaches zero