import.sh
---------------------------------------------------------------------------------------------------------- 
Skrypt pobiera dane o katastrofach z serwisu Infochimps w formacie tsv, konwertuje je na format json i importuje do bazy CouchDB podanej przez u¿ytkownika

Wywo³anie: 
	
	./import.sh host port

host - nazwa hosta, na którym uruchomiona jest baza CouchDB

port - port na którym dostêpna jest baza

export.sh 
-----------------------------------------------------------------------------------------------------------
Skrypt eksportuje dane o katastrofach z bazy CouchDB do bazy MongoDB podanej przez u¿ytkownika. Do dzia³ania wymaga modu³u couchapp do node.js

Wywo³anie: 
	
	./export.sh host port1 port2

host - nazwa hosta, na którym uruchomione s¹ bazy

port1 - port na którym dostêpna jest baza CouchDB

port2 - port na którym dostêpna jest baza MongoDB

json_view.js
------------------------------------------------------------------------------------------------------------
Widok i lista do bazy CouchDB s³u¿¹ca do pobrania danych w formacie json

couchdb_map_reduce.js
------------------------------------------------------------------------------------------------------------
Funkcje map-reduce dla bazy CouchDB i danych o katastrofach.

Do poprawnej instalacji funkcji potrzebna jest platforma Node.js, menad¿er pakietow npm oraz pakiet couchapp.

Instalacja:

	couchapp push couchdb_map_reduce.js http://localhost:5984/disasters 


Przyk³ady zapytañ (odpytywane w przegl¹darce):

Suma zabitych w powodziach: 
	
	http://localhost:5984/disasters/_design/app/_view/by_killed?key="Flood"
	
OdpowiedŸ serwera:

	{"rows":[
	{"key":null,"value":6911040}
	]}

Liczba wypadków w transporcie: 
	
	http://localhost:5984/disasters/_design/app/_view/by_type?key="Transport Accident"
	
OdpowiedŸ serwera:

	{"rows":[
	{"key":null,"value":4155}
	]}

Wszystkie rodzaje wypadków i ich liczba: 
	
	http://localhost:5984/disasters/_design/app/_view/by_type?group=true
	
OdpowiedŸ serwera(fragment):

```json
{"rows":[
{"key":"Complex Disasters","value":12},
{"key":"Drought","value":561},
{"key":"Earthquake (seismic activity)","value":1120},
{"key":"Epidemic","value":1179},
{"key":"Extreme temperature","value":361},
{"key":"Flood","value":3512},
{"key":"Industrial Accident","value":1190},
{"key":"Insect infestation","value":83},
{"key":"Mass movement dry","value":48},
```
	

Liczba zabitych w poszczególnych rodzajach wypadków: 

	http://localhost:5984/disasters/_design/app/_view/by_killed?group=true
	
OdpowiedŸ serwera(fragment):

	{"rows":[
	{"key":"Complex Disasters","value":5610000},
	{"key":"Drought","value":11708271},
	{"key":"Earthquake (seismic activity)","value":2311491},
	{"key":"Epidemic","value":9555059},
	{"key":"Extreme temperature","value":108938},
	{"key":"Flood","value":6911040},
	{"key":"Industrial Accident","value":49797},
	{"key":"Insect infestation","value":0},

Suma zabitych w Nowym Jorku: 
	
	http://localhost:5984/disasters/_design/app/_view/by_location?startkey="New York"&endkey="New-York"
	
OdpowiedŸ serwera:

	{"rows":[
	{"key":null,"value":2313}
	]}

mongodb_map_reduce.js
--------------------------------------------------------------------------------------------------------------
Funkcje map-reduce dla bazy MongoDB i danych o katastrofach.

Wywo³anie:

	mongo mongodb_map_reduce.js --shell

Przyk³ady zapytañ (odpytane automatycznie, w pow³oce mongo):

Suma zabitych w epidemiach: 

	db.disasters.mapReduce(m3, r1, {out: { inline : 1}});
	
OdpowiedŸ serwera(fragment):

	"results" : [
                {
                        "_id" : [
                                "Epidemic",
                                1
                        ],
                        "value" : 9555059
                }
        ],


Wszystkie rodzaje wypadków i ich liczba: 
	
	db.disasters.mapReduce(m1, r1, {out: { inline : 1}});

OdpowiedŸ serwera(fragment):

	"results" : [
                {
                        "_id" : "Complex Disasters",
                        "value" : 12
                },
                {
                        "_id" : "Drought",
                        "value" : 561
                },
                {
                        "_id" : "Earthquake (seismic activity)",
                        "value" : 1120
                },
                {
                        "_id" : "Epidemic",
                        "value" : 1179
                },


Liczba zabitych w poszczególnych rodzajach wypadków: 
	
	db.disasters.mapReduce(m2, r1, {out: { inline : 1}});
	
OdpowiedŸ serwera(fragment):

	"results" : [
                {
                        "_id" : "Complex Disasters",
                        "value" : 5610000
                },
                {
                        "_id" : "Drought",
                        "value" : 11708271
                },
                {
                        "_id" : "Earthquake (seismic activity)",
                        "value" : 2311491
                },
                {
                        "_id" : "Epidemic",
                        "value" : 9555059
                },


Œrednia liczba zabitych w jednej epidemii: 
	
	db.disasters.mapReduce(m3, r2, {out: { inline : 1}});
	
OdpowiedŸ serwera(fragment):

	"results" : [
                {
                        "_id" : [
                                "Epidemic",
                                1
                        ],
                        "value" : 5685.20440445735
                }