#!/bin/bash
#skrypt konwertuje dane o katastrofach ze portalu Infochimps z formatu tsv na format json i eksportuje do bazy ChouchDB

if [ "$#" == 0 ]
	then
	echo 'Zle wywolanie skryptu, uruchom z opcja -h aby uzyskac pomoc'
elif [ "$1" == '-h' ]
	then
	echo 'Skrypt pobiera dane o katastrofach w formacie tsv, konwertuje je na format json i importuje do bazy CouchDB podanej przez uzytkownika'
	echo '-----------------------------------------------------------------'
	echo 'Wywolanie: ./import.sh host port'
	echo 'host - nazwa hosta, na ktorym uruchomiona jest baza CouchDB'
	echo 'port - port na ktorym dostepna jest baza'
else
	wget http://sigma.ug.edu.pl/~akawczyn/disasters.tsv
	echo '{"docs": [' > disasters.json
	export FIELDS=start,end,country,location,type,sub_type,name,killed,cost,affected,id
	cat disasters.tsv | ruby -rjson -ne 'puts ENV["FIELDS"].split(",").zip($_.strip.split("\t")).inject({}){|h,x| h[x[0]]=x[1];h}.to_json' | sed 's/}/},/' >> disasters.json
	echo ']}' >> disasters.json
	curl -X PUT 'http://'$1':'$2'/disasters'
	curl -X POST -H "Content-Type: application/json" --data @disasters.json http://$1:$2/disasters/_bulk_docs
	rm disasters.tsv disasters.json
fi