#!/bin/bash
#
# this script demonstrates using positional parameters
# also known as command line options and arguments

while [ $# -gt 0 ]; do
	echo "$1"
	shift
done