#!/bin/bash
# this script displays how many files are in Picture directory
# how much space they used
# and the sizes and name the three largest files

echo -n There are  `find ~/Pictures -type f | wc -l`
echo " files in Pictures directory"
echo " The Pictures directory uses(In KBytes):"
du -sk ~/Pictures
echo "The largest files in Pictures directory are:"
cd ~/Pictures
find . -type f -exec du -s {} \; | sort -n | tail -3
