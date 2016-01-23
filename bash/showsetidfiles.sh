#!/bin/bash

# This script displays setidfiles

echo "Find all SUID files:"

find /usr -perm -4000 -print

echo "Find all SGID files:"

find /usr -perm -2000 -print 