
dir1='/ORA/dbs01/syscontrol/projects'
dir2='/root/packages/'

all_projects=`ls /root/projects`

for name in $all_projects; do
results=`find $dir2 -maxdepth 2 -type d -name $name -exec echo "Found " {} \;`
if [ "$results" = "" ]; then
	echo "NOT FOUND: $name"
fi
done

echo ""

diff --brief -r /root/projects/ /ORA/dbs01/syscontrol/projects
