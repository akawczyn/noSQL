var couchapp = require('couchapp');
ddoc = {
  _id: '_design/app'
  , views: {}
  , lists: {}
}
module.exports = ddoc;

ddoc.views.view = {
  map: function(doc) {
    emit(null, doc);
  }
}

ddoc.lists.to_json = function(head, req) {
 
 provides('json', function() {
        var results = [];

        while (row = getRow()) {
            results.push({
                affected: row.value.affected,
				cost: row.value.cost,
				country: row.value.country,
				end: row.value.end,
				id: row.value.id,
				killed: row.value.killed,
				location: row.value.location,
				name: row.value.name,
				start: row.value.start,
				sub_type: row.value.sub_type,
				type: row.value.type
            });
        }
		send(JSON.stringify(results));
    });
} 