# Remove old rpms

rpms=`rpm -qa | grep cerndb`

for i in $rpms; do
	echo "rpm -e $i" 
	rpm -e $i
	if [ ! $? -eq 0 ]; then
		echo "Error"
		exit 1
	fi
done

rm -rf /ORA

rpm_directory='/root/rpmbuild/RPMS/noarch/'

to_install=`ls $rpm_directory`


for i in $to_install; do
	p="$rpm_directory/$i"
	echo "rpm -i $p"
	rpm -i $p
done
