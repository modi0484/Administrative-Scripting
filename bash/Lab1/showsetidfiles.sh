#!/bin/bash

# This script displays setidfiles in /usr

echo "Display all SUID files:"

echo "------------------------------"

find /usr -perm -4000 -type f -ls -print

echo "====================================================="

echo "Display all SGID files:"

echo "------------------------------"

find /usr -perm -2000 -type f -ls -print 