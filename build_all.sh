#!/bin/bash

xclean=0
xsync=0
xmake=0
xcopy=0
xbuild=0
xall=0
xreinstall=0

while [ $# -gt 0 ]; do

	case $1 in
		"--clean")
			xclean=1				
		;;
		"--sync")
			xsync=1				
		;;
		"--make")
			xmake=1
		;;
		"--copy")
			xcopy=1				
		;;
		"--build")
			xbuild=1				
		;;
		"--all")
			xall=1				
		;;
		"--reinstall")
			xreinstall=1				
		;;

	esac
	shift
done

if [ $xall -eq 1 ]; then
	echo "Rebuild all"
	xclean=1
	xsync=1
	xmake=1
	xcopy=1
	xbuild=1
fi

if [ $xclean -eq 1 ]; then
	# Clean prevoius builds
	rm -f ~/rpmbuild/RPMS/noarch/*
	rm -f ~/rpmbuild/SOURCES/*
fi


if [ $xsync -eq 1 ]; then
	# sync from golden copy
	./sync_from_golden_copy.sh
fi

# and the processing


current_dir=`pwd`
directories=`find . -maxdepth 1 -type d`


if [ $xmake -eq 1 ]; then
	for i in $directories; do
		new_dir="$current_dir/$i"
		cd $new_dir
		echo ">>>>   BUILDING $new_dir"
		make
	done
fi


if [ $xcopy -eq 1 ]; then
		# Copy all archives to SOURCES
	echo ">>>>    COPY TO SOURCES"

	cd $current_dir
	find . -maxdepth 2 -type f -name *.tar.gz -exec mv {} /root/rpmbuild/SOURCES/ \;
fi

if [ $xbuild -eq 1 ]; then
	# Exec rpmbuilds
	echo ">>>>    RPMBUILDS"

	cd $current_dir
	find . -maxdepth 2 -name *.spec -exec rpmbuild --clean -ba {} \;
fi


if [ $xreinstall -eq 1 ]; then
	./reinstall_rpms.sh
fi


