#!/bin/bash
# This script is for backup of bin directory

cd ~
rsync -av bin/. backups/