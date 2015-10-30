
xaddversion=0
xgit=0
xkoji=0
xall=0

while [ $# -gt 0 ]; do

	case $1 in

		"--version")
			xaddversion=1
			;;
		"--git")
			xgit=1
			;;
		"--koji")
			xkoji=1
			;;
		"--all")
			xaddversion=1
			xgit=1
			xkoji=1
			;;
	esac

	shift

done

# Change release number in all specs

specfiles=`find . -maxdepth 2 -type f -name *.spec`

if [ $xaddversion -eq 1 ]; then
	echo ">>>>>>>>> INCREASING VERSION NUMVER <<<<<<<<<"
	for file in $specfiles; do
		echo "$file"
		ver=`grep "Version:" $file`
		version=`echo "$ver" | awk '{print $2}'`
		echo "Old version: $version"
		new_version=`awk -v vpct="$version" 'BEGIN{print vpct+0.1}'`
		echo "New version: $new_version"
		sed -i "s/Version:\t.*/Version:\t$new_version/" $file	
	done
fi

if [ $xgit -eq 1 ]; then
	# Git add all/ commit and push
	echo ">>>>>>>>> GIT ADD COMMIT PUSH <<<<<<<<<"
	my_dir=`pwd`
	directories=`find . -mindepth 1 -maxdepth 1 -type d`

	for d in $directories; do
		echo "Git add commit and push in $d"
		cd $d
		git add .
		git add -u
		git commit -m "Update of the RPM"
		git push origin master
		cd $my_dir
		echo ""
	done
fi

# generate koji commands with proper commit number

if [ $xkoji -eq 1 ]; then
	echo ">>>>>>>>> GENERATE KOJI COMMANDS <<<<<<<<<<"
	my_dir=`pwd`
	directories=`find . -mindepth 1 -maxdepth 1 -type d`

	for d in $directories; do
		cd $d
		base_dir=`basename $d`

		commit=`git log --pretty=oneline -n 1 | awk {'print substr($1,1,6)'}`
		echo "koji build db6 \"git+ssh://git@gitlab.cern.ch:7999/db/$base_dir.git#$commit\""


		cd $my_dir
	done
fi
