#!/bin/bash
# This script will display default directory ~/Pictures
# Disk usage by Pictures directory and also display  3 biggest files in ~/Pictures directory

#Variable Declaration
##############################
defaultdir=~/Pictures # set ~/Picture directory to default directory

# create a fuction userhelp for user for command help
userhelp(){
  echo "Usage: $0 [-c] [-h] [directory_name]"
  echo "FYI: default directory is ~/Picture"
  
  echo "options : "
  
  echo " -c option is count value, --count"
  echo " -h option is for help, --help "
}

# create a fuction error-message for send error to stderr
######################################################
errormessage(){
        echo "Usage: $0 [-c] [-h] [directory_name]"
		echo "Argument '$1' not recognized" >&2
}


# MAIN SCRIPT#
#############

# following is a while loop which check files count in mention drectory and help option from command line options

while [ $# -gt 0 ]; do
	case "$1" in
	-h|--help )
		userhelp # call fuction help for user
		exit 0
		;;
    -c| --count )
        if [ "$2" -eq 0 ]; then
            errormessage "There is no files in ~/Pictures diectory. Make sure you have at least 3 files"
            exit 2
           shift
        else
            echo "There are total $filecount files in the ~/Pictures directory"
            exit 0
        fi
       ;;
       
     *)
       errormessage "Invalid Argument $1"
       exit 2
       
    esac
done

        
        
        
        
# following command will count how many files in ~/Pictures directory   
filecount=`find ~/Pictures -type f | wc -l`
echo "There are total $filecount files in the ~/Pictures directory"


# checking the directory is empty or not
############################################
diskusage=0 # default is 0Kbytes if no files in there

if [ $filecount -ne 0 ]; then 

        diskusage=`du -sh $defaultdir |awk '{print $1}'` # following command will show you the disk usage of ~/Picture directory
        echo "The Pictures directory uses: $diskusage" 
else
        echo "The Pictures directory uses: $diskusage[K]"
fi


# checking the directory has 3 picture files or not
####################################################
if [ $filecount -eq 3 ]; then 
            errormessage "you should have at least 3 picture files"
            exit 2
else
        echo "The 3 largest files in the ~/Pictures directory are: "
        cd ~/Pictures
        find . -type f -exec du -h {} \; | sort -h | tail -3 # this command fetches 3 biggest files from ~/Pictures directory
        
fi