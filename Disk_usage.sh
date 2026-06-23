#!/bin/bash

Disk_info=$(df -h | grep -v Filesystem)
Threshold=$1

while read -r cpu
do
 
cpu_perc=$(echo $cpu | awk '{print $5}'| sed 's/%//')

    if [ "$cpu_perc" -ge "$Threshold" ]; then

        Filesystem=$(echo $cpu | awk '{print $1}')
        echo "Disk utilisation is $cpu_perc on partition $Filesystem" 
    fi

done <<< "$Disk_info"