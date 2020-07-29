#! /bin/bash

# Check Disk Usages
PART=sda1
DISKUSE=$(df -h | grep $PART | awk '{ print $5 }' | cut -d'%' -f1)
echo "Disk used: $DISKUSE"

# CPU
CPUUSE=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage ""}')
echo "CPU used: $CPUUSE"
