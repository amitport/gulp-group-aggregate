var groupAggregatePlugin = require('../');
var assert = require('assert');
require('mocha');

describe('gulp-group-aggregate', function() {
	describe('groupAggregatePlugin()', function() {
		it('should group items by string', function(done) {
			var stream = groupAggregatePlugin({
				group: function (obj){return obj.str;}, 
				aggregate: function (str, objs){
					assert.equal(objs.length, 2, 'there should be 2 groups');
					return {contents: new Buffer(JSON.stringify({str:str, sum:objs[0].val+objs[1].val}))};
				}
			});

			stream.write({str: 'a', val: 1});
			stream.write({str: 'b', val: 2});
			stream.write({str: 'a', val: 3});
			stream.write({str: 'b', val: 5});

			var count = 0;
			stream.on('data', function(data){
				data = JSON.parse(data.contents.toString());
				count++;
				if (data.str === 'a') {
					assert.equal(data.sum, 4, 'aggregate should calculate the sum');
				} else if (data.str === 'b') {
					assert.equal(data.sum, 7, 'aggregate should calculate the sum');
				} else {
					assert.fail(data.str, "'a' or 'b'", 'aggregate should only create object with an existing str')
				}
			});
			stream.on('end', function(){
				assert.equal(count, 2, 'aggregate should create exactly two objects');
				done();
			});
			stream.end();
		})
	});
});