#!/bin/bash

dbmanuser=root
dbmanhost=itrac50044
dbmanpath=/ORA/dbs01/syscontrol/projects
directory=

while [ $# -gt 0 ];do

	case $1 in
		"--dir")
			directory=$2
			shift
		;;
	esac
	shift
done

if [ "$directory" = "" ]; then
	echo "--dir directory"
	exit 1
fi

find $directory -mindepth 1 -maxdepth 1 -type d -not -name '\.*' -printf "%f\n" | while read dir
do
	
	echo rsync -av "${dbmanuser}@${dbmanhost}:${dbmanpath}/${dir}" $directory/
	rsync -av --delete "${dbmanuser}@${dbmanhost}:${dbmanpath}/${dir}" $directory
done
