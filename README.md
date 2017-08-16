# gulp-group-aggregate [![NPM version][npm-image]][npm-url] [![NPM dep][npm-dep-image]][npm-dep-url] [![Build status][travis-image]][travis-url]
> a group and aggregate plugin for gulp

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
  gulp.src(...)
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
    .pipe(gulp.dest(...));
});
```

## API

gulp-group-aggregate is a ```function(options)``` that returns a ```read-write stream```. The _options_ argument should include two functions: _group_ and _aggregate_.

#### options.group

Type: ```function(File)``` returns ```string```

Receives a [vinyl](https://github.com/wearefractal/vinyl) from the stream and returns a string which represents its group. 

#### options.aggregate

Type: ```function(string, File[])``` returns ```File.options or {falsy value} or Promise<File.options or {falsy value}>``` 

Receives a group string as returned from _group_ calls and an array of all the files associated with it. Returns a [vinyl constructor.options](https://github.com/wearefractal/vinyl#constructoroptions) object. The options will be used to construct a file which will be pushed through the stream. The callback can also return a Promise that evalutes a [vinyl constructor.options](https://github.com/wearefractal/vinyl#constructoroptions) object. Additionally, if it or the promise returns a falsy value the group will be filtered out.

[travis-url]: http://travis-ci.org/amitport/gulp-group-aggregate
[travis-image]: https://secure.travis-ci.org/amitport/gulp-group-aggregate.svg?branch=master
[npm-url]: https://npmjs.org/package/gulp-group-aggregate
[npm-image]: https://badge.fury.io/js/gulp-group-aggregate.svg
[npm-dep-url]: https://david-dm.org/amitport/gulp-group-aggregate
[npm-dep-image]: https://david-dm.org/amitport/gulp-group-aggregate.svg

