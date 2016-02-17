#!/bin/bash

file1="/home/ubuntu/Pictures"
file2="/home/ubuntu/backups"
file3="/home/ubuntu/bin"
file4="/home/ubuntu/lib"
file5="/home/ubuntu/workspace"

echo "1) $file1"
echo "2) $file2"
echo "3) $file3"
echo "4) $file4"
echo "5) $file5"

read -p "Choose a file by specifying the choice number [press enter to choose neither]: " choice
if [ "$choice" == 1 ]; then
	more $file1
elif [ "$choice" == 2 ]; then
	echo "you chose $file2"
elif [ "$choice" == 3 ]; then
	echo "you chose $file3"
elif [ "$choice" == 4 ]; then
	echo "you chose $file4"
elif [ "$choice" == 5 ]; then
	echo "you chose $file5"
	
else
	echo "You chose neither file"
fi