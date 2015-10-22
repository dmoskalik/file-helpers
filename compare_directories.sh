#!/bin/bash


action=
minlevel=0
maxlevel=
top_directory=

while [ $# -gt 0 ]; do

	case "$1" in
		"--compare")
			action="compare"
			;;
		"--directory")
			top_directory="$2"
			shift
			;;
		*)

	
	;;
	esac
	shift
done


if [ "$action" = 'compare' ]; then
	# Compare two directories, compare directory name
	directories=`ls $top_directory`

	echo "top dir: $top_directory"
	for i in $directories; do
		echo "Comparing $i"
		path="$top_directory/$i"
		file_list=`find $path -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | grep -v .git | sort`
		for n in $directories; do
			if [ "$n" = "$i" ]; then
				continue
			fi
			path2="$top_directory/$n"
			file_list2=`find $path2 -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | grep -v .git | sort`
			for dir_name in $file_list; do
				for dir_name2 in $file_list2; do
					if [ "$dir_name" = "$dir_name2" ]; then
						echo -e "\tThe same in: $n ($dir_name)"	
					fi
				done

			done
		done
	done

fi
