#!/bin/bash
#
# this script will print out a welcome message in a predefined format
#
# VARIABLES
###########
myname="Akash Modi"
mytitle="A CSTN Student"
hostname=`hostname`
weekday=$(date +%A)

# MAIN
######
echo "Welcome to planet $hostname, $mytitle $myname!"
echo "Today is $weekday"