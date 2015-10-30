# Generate links for KOJI
rm -f ~/rpmbuild/RPMS/noarch/*
rm -f ~/rpmbuild/SOURCES/*

#Only bin
find -L . -xtype l -exec ls -l {} \; | awk '{print "ln -sf ",$11, " $RPM_BUILD_ROOT/ORA/dbs01/syscontrol/"$9}' | grep syscontrol/./bin

#Only etc
find -L . -xtype l -exec ls -l {} \; | awk '{print "ln -sf ",$11, " $RPM_BUILD_ROOT/ORA/dbs01/syscontrol/"$9}' | grep syscontrol/./etc

# NOT syscontrol/etc and syscontrokl bin
find -L . -xtype l -exec ls -l {} \; | awk '{print "ln -sf ",$11, " $RPM_BUILD_ROOT/ORA/dbs01/syscontrol/projects/"$9}' | grep -v projects/./bin | grep -v projects/./etc

# Universal
find -L . -xtype l -exec ls -l {} \; | awk '{print "ln -sf ",$11, " $RPM_BUILD_ROOT/ORA/dbs01/syscontrol/projects/"$9}'
