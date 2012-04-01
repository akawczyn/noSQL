var couchapp = require('couchapp');
ddoc = {
    _id: '_design/app'
  , views: {}
}
module.exports = ddoc;

ddoc.views.by_type = {
  map: function(doc) {
       emit(doc.type, doc.sub_type);
  },
  reduce: "_count"
}

ddoc.views.by_killed = {
  map: function(doc) {
       emit(doc.type,parseInt(doc.killed));
  },
  reduce: function(keys,values) {
    return sum(values);
  } 
}

ddoc.views.by_location = {
  map: function(doc) {
       emit(doc.location, parseInt(doc.killed));
  }, 
  reduce: function(keys,values) {
    return sum(values);
  }
}