#!/bin/bash
#Skrypt eksportuje dane o katastrofach z bazy CouchDB do bazy MongoDB podanej przez uzytkownika

if [ "$#" == 0 ]
	then
	echo 'Zle wywolanie skryptu, uruchom z opcja -h aby uzyskac pomoc'
elif [ "$1" == '-h' ]
	then
	echo 'Skrypt eksportuje dane o katastrofach z bazy CouchDB do bazy MongoDB podanej przez uzytkownika'
	echo '-----------------------------------------------------------------'
	echo 'Wywolanie: ./export.sh host port1 port2'
	echo 'host - nazwa hosta, na ktorym uruchomione sa bazy'
	echo 'port1 - port na ktorym dostepna jest baza CouchDB'
	echo 'port1 - port na ktorym dostepna jest baza MongoDB'
else
	couchapp push json_view.js http://$1:$2/disasters
	curl 'http://'$1':'$2'/disasters/_design/app/_list/to_json/view' | sed -e 's/},/&\n/g;s/\[//g;s/\]//g;s/},/}/g' > disasters.json
	mongoimport --host localhost --port $3 --db test --collection disasters --type json --file disasters.json
	rm disasters.json
fi