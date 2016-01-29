#!/bin/bash

# This script displays setidfilesbash

echo "Display all SUID files:"

find /usr -perm -4000 -print

echo "Display all SGID files:"

find /usr -perm -2000 -print 