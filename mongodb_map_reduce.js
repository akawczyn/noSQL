m1 = function() {
  emit(this.type,1);
};

m2 = function() {
  if(this.killed!='')
     emit(this.type,parseInt(this.killed));
};

m3 = function() {
  if(this.killed!='' && this.type=='Epidemic')
     emit([this.type,1],parseInt(this.killed));
};

r1 = function(key, values) {
  var sum = 0;
  values.forEach(function(count) {
    sum += count;
  });
  return sum;
};

r2 = function(key, values) {
  var sum = 0,all = 0;
  values.forEach(function(count) {
    sum += count;
	all += key[1];
  });
  return sum/all;
};

print('Suma zabitych w epidemiach:');
res = db.disasters.mapReduce(m3, r1, {out: { inline : 1}});
printjson(res);
print('Wszystkie rodzaje wypadkow i ich liczba:');
res = db.disasters.mapReduce(m1, r1, {out: { inline : 1}});
printjson(res);
print('Liczba zabitych w poszczegolnych rodzajach wypadkow:');
res = db.disasters.mapReduce(m2, r1, {out: { inline : 1}});
printjson(res);
print('Srednia liczba zabitych w jednej epidemii:');
res = db.disasters.mapReduce(m3, r2, {out: { inline : 1}});
printjson(res);