#!/bin/bash
#
#
#make a DB list
DB_LIST=$(ssh root@10.0.0.253 "psql -U koksztys -l" | sed '1,3d'|awk '{print $1}' | sed '/:/d' |sed 'N;$!P;$!D;$d')
#IP address of remote machine with DB's
IP="10.0.0.253"
#from DB_LIST dump one by one DB to the local file on backup machine
for DB in $DB_LIST; do 
((i++))
	echo $i
#	echo $list
	ssh root@$IP "pg_dump -U koksztys -C --column-inserts $DB " > $DB.out
done

