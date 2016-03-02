#!/bin/bash

# This script will count down to 0 from the specified number of seconds.
# The user has the option to specify the countdown interval (in seconds).
# A SIGINT signal will reset the timer to the inital value.
# A SIGQUIT signal will exit.
#
# Michael Sartori - Feb 20, 2016



# get the filename of this script
filename=$(basename ${BASH_SOURCE[0]})


# get the full path of this script
get_filepath() {
	src="${BASH_SOURCE[0]}"
	
	# resolve symlinks
	while [ -h "$src" ]; do
		dir="$(cd -P "$(dirname "$src")" && pwd)"
		src="$(readlink "$src")"
		[[ $src != /* ]] && src="$dir/$src"
	done

	dir="$(cd -P "$(dirname "$src")" && pwd)"
	echo "$dir/"
	unset src
	unset dir
}


# display command help
cmdhelp() {
	cat <<-EOF
		Usage: $filename [OPTIONS...] SECONDS
		Countdown timer
                
		Optional Arguments:
		-i, --interval=VALUE	interval (in seconds) to count by [default=1]
		Description:
		The script will count down to 0 from the specified number of seconds.
		A ^C will reset the timer to the inital value.
		Use ^\ to exit.
		Example:
		$filename 10
	EOF
}


# send information regarding incorrect syntax to STDERR
error-message() {
	echo "$filename: $1" >&2
	echo "Try '$filename --help' for more information" >&2
}


# convert seconds to HH:MM:SS
convertsecs() {
	h=$(( $1 / 3600 ))
	m=$(( $1 / 60 % 60 ))
	s=$(( $1 % 60 ))
	printf "%02d:%02d:%02d\n" $h $m $s
	unset h
	unset m
	unset s
}


# return comments at specific times during countdown
comment() {
	case $1 in
	540) echo "GO for launch! Start automatic ground launch sequencer." ;;
	450) echo "Retract orbiter access arm." ;;
	300) echo "Start auxillary power units. Arm solid rocket booster range safety safe and arm devices." ;;
	235) echo "Start orbiter aerosurface and main engine gimbal profile tests." ;;
	175) echo "Retract gaseous oxygen vent arm." ;;
	120) echo "Crew members: close and lock visors."	;;
	50) echo "Transfer orbiter to internal power." ;;
	31) echo "Ground launch sequencer is GO for auto sequence start." ;;
	16) echo "Activate launch pad sound supression system." ;;
	10) echo "Activate main engine hydrogen burnoff system." ;;
	6) echo "Main engine start." ;;
	1) echo "Solid rocket booster ignition." ;;
	0) echo "Liftoff of $(hostname) at $(date '+%r %Z')"
	esac
}


# countdown timer
countdown() {
	[ ! "$interval" ] && interval=1  # if the interval has not been defined, set to 1 sec
	for (( i=$1 ; i >= 0 ; i-=$interval )); do  # loop from initial value to 0 by interval
		printf "%s%s  %s\n" "T-" "$(convertsecs $i)" "$(comment $i)" # print timer and comment to STDOUT
		if [ $i -ge $interval ]; then  # if the timer is greater than or equal to the interval
			sleep $interval  #+ then sleep for the interval (in seconds)
		elif [ $i -gt 0 ]; then  # else if the timer is greater than 0
			sleep $i  #+ sleep for the value of the timer
			i=$interval  #+ and set the timer to the interval (because the loop will subtract the interval from the timer)
		fi			#+ this allows the loop to display the timer at 0
	done
}


# for the SIGINT trap
sigint() {
	printf "\n%s\n" "Alright... let's take it from the top"
	exec bash "$(get_filepath)$filename" "$init" "--interval=$interval"  # replace current process with a new process of the script (start over)
}


# for the SIGQUIT trap
sigquit() {
	printf "\n%s\n%s\n\n" "!!!!!  LAUNCH SEQUENCE ABORT  !!!!!" "What did you go and do that for? We were having so much fun."
	exit 131
}


# for processing the [-i|--interval] command line option
args_interval() {
	if [[ "$2" =~ ^[[:digit:]]+$ ]]; then  # if the value is a number
		if [[ $2 -ge 1 && $2 -le 2147483648 ]]; then  # if the value is an integer from 1 to 2147483648 (32-bit signed number)
			interval=$2
		else	
			error-message "interval must be between 1 and 2147483648, inclusive"
			exit
		fi
	else
		error-message "invalid interval -- '$1'"
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
	case $1 in
	-h|--help)
		cmdhelp
		exit 0
		;;
	-i)
		if [ ! "$interval" ]; then  # if the interval has not already been set
			args_interval "-i" "$2"
			shift
		else
			error-message "duplicate argument -- '-i'"
			exit 2
		fi
		;;
	--interval=*)
		if [ ! "$interval" ]; then  # if the interval has not already been set
			args_interval "--interval" "$(echo "$1" | sed 's/^--interval=//')"
		else
			error-message "duplicate argument -- '--interval'"
			exit 2
		fi
		;;
	*)
		if [[ "$1" =~ ^[[:digit:]]+$ ]]; then  # if the value is a number
			if [ "$init" ]; then  # if the inital value has already been set
				error-message "invalid argument -- '$1'"
				exit 2				
			elif [[ $1 -ge 1 && $1 -le 2147483648 ]]; then  # else if the value is between 1 and 2147483648 (32-bit signed number)
				init=$1
			else  # if the number is outside the allowed range
				error-message "must specifiy an initial value between 1 and 2147483648, inclusive"
				exit 2
			fi
		else  # if the value is not a number
			error-message "invalid argument -- '$1'"
			exit 2
		fi
		;;
	esac
	shift
done


if [ "$init" ]; then  # if the inital value has been set
	# the trap signals are here and not at the top of the main becuase the called functions use variables that are not defined until this point
	#+ also because the signals should not result in a call to these functions until the timer has started
	trap sigint SIGINT  # trap SIGINT signal (^C) and call sigint()
	trap sigquit SIGQUIT  # trap SIGQUIT signal (^\) and call sigquit()
	countdown $init  # begin countdown
else  # if the inital value has not been set
	error-message "must specify an inital value"
	exit 2
fi