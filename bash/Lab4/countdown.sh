#!/bin/bash

# This script will display the disk usage for the files in the ~/Pictures directory and also show the three largest files
# The user has the option to specify at the command line a different directory and/or a different number of files to show
#
# Michael Sartori - Jan 22 2016



# get filename of this script
filename=$(basename ${BASH_SOURCE[0]})

# set default directory to ~/Pictures
dir="$HOME/Pictures"


# display command help
cmdhelp() {
	cat <<-EOF
		Usage: $filename [OPTION...] [DIRECTORY]
		Show total disk usage and largest files in a directory
		Will use the ~/Pictures directory by default
		Optional arguments:
                
		-c, --count=VALUE	specify how many of the top largest files to display [default=3]
                
		Examples:
                
		$filename /var
		$filename -c 5 /tmp
		$filename --count=2 /tmp
	EOF
}


# send information regarding incorrect syntax to STDERR
error-message() {
        echo "$filename: $1" >&2
        echo "Try '$filename --help' for more information" >&2
}


# for processing the [-c|--count] command line option
args_count() {		
	if [ $2 -gt 0 ] 2>/dev/null; then
		count=$2
	else
		error-message "invalid argument -- '$1'"
		exit 2
	fi
}



#######
# MAIN
#######


# evaluate arguments passed from command line,
#+ looping until all arguments have been processed or
#+ an invalid argument is detected
# an invalid argument will cause the script to exit with status 2
while [ $# -gt 0 ]; do
	case "$1" in
	-h|--help )
		cmdhelp
		exit 0
		;;
	-c )
		if [ ! "$count" ]; then
			args_count '-c' "$2"
			shift
		else
			error-message "duplicate argument -- '-c'"
			exit 2
		fi
		;;
	--count=* )
		if [ ! "$count" ]; then
			args_count '--count' $(echo "$1" | sed 's/^--count=//')
			shift
		else
			error-message "duplicate argument -- '--count'"
			exit 2
		fi
		;;
	* )
		if [ -d "$1" ]; then
			dir="$1"
		else
			error-message "directory does not exist"
			exit 1
		fi
	esac
	shift
done


# set $count to 3 if not already set
[ ! "$count" ] && count=3

# find total disk usage of the files in $dir
diskUsage=$(du -sh $dir 2>/dev/null)
if [ $? -ne 0 ]; then # check for error status from du command
	error-message "error while reading directory (check permissions)"
	exit 1
else
	diskUsage=$(echo $disKUsage | awk '{print $1}')
fi

# find number of files in $dir
numfiles=$(find $dir -type f |  wc -l)

# if count larger than $numfiles, set to value of $numfiles
[ $count -gt $numfiles ] && count=$numfiles

# display results if there is at least one file in the directory
if [ $numfiles -gt 0 ]; then
	cat <<-EOF
		There are $numfiles files in the $dir directory, with a total disk usage of $diskUsage
		Here are the $count largest files, in order, with their respective file sizes:
	EOF
else
	echo "There are no regular files in $dir"
	exit 1
fi

# show the largest files in order up to the number of files set in $count
find $dir -type f -exec du -h {} \; | sort -hr | head "-$count"
