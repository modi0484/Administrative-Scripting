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

############ create a fuction error-message for send error to stderr #############
######################################################
errormessage(){
        echo "Usage: $0 [-i] [-h] [secs]"
		echo "Argument '$1' not recognized" >&2
}

# Normally traps catch signals and do something useful or necessary with them
# These functions are for use with traps for signals we want to catch
# Quit if we get SIGQUIT, but let the user know why we are exiting
# Squawk if we get SIGHUP
# If we get SIGINT, we reset the counter to where it started

# trap the signals we care about and use them to invoke the functions above

#### Main Script #########
##############################

# Process command line parameters

# display what is left in our count
# sleep until it is time for the next display
# end the script when the count reaches zero