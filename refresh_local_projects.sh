#!/bin/bash
dbmanuser=root
dbmanhost=itrac50044
localpath=/root/
dbmanpath=/ORA/dbs01/syscontrol/projects

rsync -av ${dbmanuser}@${dbmanhost}:${dbmanpath} $localpath
