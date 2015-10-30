#!/bin/bash
dbmanuser=root
dbmanhost=itrac50044
localpath=/mnt/
dbmanpath=/ORA/dbs01/syscontrol/projects

rsync -av --delete ${dbmanuser}@${dbmanhost}:${dbmanpath} $localpath
