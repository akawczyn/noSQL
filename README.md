import.sh
---------------------------------------------------------------------------------------------------------- 
Skrypt pobiera dane o katastrofach z serwisu Infochimps w formacie tsv, konwertuje je na format json i importuje do bazy CouchDB podanej przez u¿ytkownika

Wywolanie: ./import.sh host port

host - nazwa hosta, na ktorym uruchomiona jest baza CouchDB

port - port na ktorym dostepna jest baza

export.sh 
-----------------------------------------------------------------------------------------------------------
Skrypt eksportuje dane o katastrofach z bazy CouchDB do bazy MongoDB podanej przez uzytkownika. Do dzia³ania wymaga modu³u couchapp do node.js

Wywolanie: ./export.sh host port1 port2

host - nazwa hosta, na ktorym uruchomione sa bazy

port1 - port na ktorym dostepna jest baza CouchDB

port2 - port na ktorym dostepna jest baza MongoDB

json_view.js
------------------------------------------------------------------------------------------------------------
widok i lista do bazy CouchDB s³u¿¹ca do pobrania danych w formacie json