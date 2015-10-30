#!/bin/bash
dbmanuser=root
dbmanhost=itrac50044
localpath=`pwd`
dbmanpath=/ORA/dbs01/syscontrol/projects

projects=`find  . -maxdepth 1 -type d -not -name '\.*' -printf '%f\n'`

for directory in $projects; do
	echo "DIR: $directory"
	find $directory -maxdepth 1 -type d -not -name '\.*' -printf '%f\n' | while read dir
	do
		if [ "$dir" = "$directory" ]; then
			continue
		fi
		echo -e "\t $dir"
		true
		echo -e "\t\trsync -av ${dbmanuser}@${dbmanhost}:${dbmanpath}/${dir} $localpath/$directory/"
		rsync -av --delete ${dbmanuser}@${dbmanhost}:${dbmanpath}/${dir} $localpath/$directory/	
	done
done
