# Remove old rpms

xall=1
xuninstall=0
xinstall=0

while [ $# -gt 0 ]; do

	case $1 in
		"--uninstall")
			xuninstall=1
			xall=0
			;;
		"--install")
			xuninstall=1
			xall=0
			;;
	esac
shift
done

if [ $xall -eq 1 ];then
	xuninstall=1
	xinstall=1	
fi


if [ $xuninstall -eq 1 ];then
	rpms=`rpm -qa | grep cerndb`

	for i in $rpms; do
		echo "rpm -e $i" 
		rpm -e $i
		if [ ! $? -eq 0 ]; then
			echo "Error"
			exit 1
		fi
	done
fi


if [ $xinstall -eq 1 ];then
	rpm_directory='/root/rpmbuild/RPMS/noarch/'

	to_install=`ls $rpm_directory`


	for i in $to_install; do
		p="$rpm_directory/$i"
		echo "rpm -i $p"
		rpm -i $p
	done
fi
