# gulp-group-aggregate [![NPM version][npm-image]][npm-url] [![Build status][travis-image]][travis-url]
> a group and aggregate plugin for gulp (and other streams)

## Usage

First, install `gulp-group-aggregate` as a development dependency:

```shell
npm install --save-dev gulp-group-aggregate
```

Then, add it to your `gulpfile.js`:

```javascript
var path = require('path');
var groupAggregate = require('gulp-group-aggregate');

var processFiles = function (files) {...}; 

gulp.task('folderWrap', function(){
  gulp.src(['all/*/*'])
  	.pipe(groupAggregate({
  		group: function (file){
  			// group by the directory name of each file
  			return path.basename(path.dirname(file.path));
  		}, 
  		aggregate: function (group, files){
  			// create a new file by processing the grouped files
  			return {
  				path: group + '.html',
  				contents: new Buffer(processFiles(files))
  			};
  		}
  	}));
    .pipe(gulp.dest('build/folder.txt'));
});
```

## API

gulp-group-aggregate is called with an _options_ object containing two functions: _group_ and _aggregate_.

### options.group(file) -> string

Receives an [vinyl](https://github.com/wearefractal/vinyl) from the stream and returns a string which represents its group. 

### options.aggregate(groupStr, files) -> File.options

Receives a group string as returned from __group__ calls and an array of all the files associated with it. Returns a [vinyl constructor.options object](https://github.com/wearefractal/vinyl#constructoroptions) which will be made into a file and pushed through the stream.

[travis-url]: http://travis-ci.org/amitport/gulp-group-aggregate
[travis-image]: https://secure.travis-ci.org/amitport/gulp-group-aggregate.png?branch=master
[npm-url]: https://npmjs.org/package/gulp-group-aggregate
[npm-image]: https://badge.fury.io/js/gulp-group-aggregate.png