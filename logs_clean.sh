#!/bin/bash

log_direc=$1
des_direc=$2
days=${3:-5}

if [ -z $log_direc ] || [ -z $des_direc ]; then
    echo "Please provide the directory path and days"
    echo "usage $0 [source_dir] [dest_dir] [default_days]"
    exit 1
fi

if [ ! -d $log_direc ]; then
    echo " $log_dire doesn't exists"
    exit 1
fi

if [ ! -d $des_direc ]; then
    echo " $des_direc doesn't exists"
    exit 1
fi


Files=$(find "$log_direc" -type f -name '*.log' -mtime "+$days")
#Directories=$(find "$log_direc" -type d -mtime "+$days")

if [ -z $Files ]; then
    echo " We don't have files older than $days"
    exit 0
fi

#if [ -z $Directories ]; then
    #echo " We don't have directories older than $days"
   # exit 1
#fi
tar -czvf $des_direc/archival.tar.gz $log_dire

if [ $? -eq 0 ]; then

echo -e "Printing the $days days older files \n"
while IFS= read -r line
do
    echo -e "$line \n"
done <<< "$Files"


echo -e "Deleting the logs older than $days in $log_direc \n"
while IFS= read -r line
do
   # rm -f $line
    echo "deleted file: $line"
done <<< "$Files"

fi

# echo -e "Printing the $days days older directories \n"
#while read -r direc
#do
   # echo -e "$direc \n"

#done <<< "$Directories" 



