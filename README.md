import.sh
---------------------------------------------------------------------------------------------------------- 
Skrypt pobiera dane o katastrofach z serwisu Infochimps w formacie tsv, konwertuje je na format json i importuje do bazy CouchDB podanej przez u¿ytkownika

Wywolanie: 
	
	./import.sh host port

host - nazwa hosta, na ktorym uruchomiona jest baza CouchDB

port - port na ktorym dostepna jest baza

export.sh 
-----------------------------------------------------------------------------------------------------------
Skrypt eksportuje dane o katastrofach z bazy CouchDB do bazy MongoDB podanej przez uzytkownika. Do dzia³ania wymaga modu³u couchapp do node.js

Wywolanie: 
	
	./export.sh host port1 port2

host - nazwa hosta, na ktorym uruchomione sa bazy

port1 - port na ktorym dostepna jest baza CouchDB

port2 - port na ktorym dostepna jest baza MongoDB

json_view.js
------------------------------------------------------------------------------------------------------------
Widok i lista do bazy CouchDB s³u¿¹ca do pobrania danych w formacie json

couchdb_map_reduce.js
------------------------------------------------------------------------------------------------------------
Funkcje map-reduce dla bazy CouchDB i danych o katastrofach.

Do poprawnej instalacji funkcji potrzebna jest platforma Node.js, menad¿er pakietów npm oraz pakiet couchapp.

Instalacja:

	couchapp push couchdb_map_reduce.js http://localhost:5984/disasters 


Przyklady zapytan (odpytywane w przegl¹darce):

	-Suma zabitych w powodziach: http://localhost:5984/disasters/_design/app/_view/by_killed?key="Flood"

	-Liczba wypadkow w transporcie: http://localhost:5984/disasters/_design/app/_view/by_type?key="Transport Accident"

	-Wszystkie rodzaje wypadkow i ich liczba: http://localhost:5984/disasters/_design/app/_view/by_type?group=true

	-Liczba zabitych w poszczególnych rodzajach wypadkow: http://localhost:5984/disasters/_design/app/_view/by_killed?group=true

	-Suma zabitych w Nowym Jorku: http://localhost:5984/disasters/_design/app/_view/by_location?startkey="New York"&endkey="New-York"


mongodb_map_reduce.js
--------------------------------------------------------------------------------------------------------------
Funkcje map-reduce dla bazy MongoDB i danych o katastrofach.

Wywo³anie:

	mongo mongodb_map_reduce.js --shell

Przyklady zapytan (odpytane automatycznie, w pow³oce mongo):

	-Suma zabitych w epidemiach: db.disasters.mapReduce(m3, r1, {out: { inline : 1}});

	-Wszystkie rodzaje wypadkow i ich liczba: db.disasters.mapReduce(m1, r1, {out: { inline : 1}});

	-Liczba zabitych w poszczególnych rodzajach wypadkow: db.disasters.mapReduce(m2, r1, {out: { inline : 1}});

	-Œrednia liczba zabitych w jednej epidemii: db.disasters.mapReduce(m3, r2, {out: { inline : 1}});