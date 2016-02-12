#!/bin/bash

# this script will show the IP address assigned to each interface as well as the default gateway


declare -a int1
declare -a int2
declare -a interfaces

#Dispays the Interfaces names
int1=`ifconfig | grep -ow "eth0"`
int2=`ifconfig | grep -ow "lo"`
echo "There are two interfaces: [$int1] and [$int2]"

#assign list of interface names to interfaces[]
for i in `ifconfig | expand | cut -c 1-8 | sort | uniq -u | grep -v lo`; do
	interfaces+=($i)
done


#parse ifconfig output for each interface defined in interfaces[] and output the assosicated IPv4 address
for i in ${interfaces[@]}; do
	addr=`ifconfig $i | grep "inet addr" | cut -d: -f2 | cut -d' ' -f1`
	echo "Interface [$i] has an IPv4 address of $addr"
done

#parse the route -n command to retrieve and display the default gateway
gw=`route -n | grep ^0.0.0.0 | awk '{print $2}'`
echo "The IPv4 default gateway is $gw"