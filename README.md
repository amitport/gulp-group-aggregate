# gulp-group-aggregate
> a group and aggregate plugin for gulp (and other streams)

## Usage

First, install `gulp-group-aggregate` as a development dependency:

```shell
npm install --save-dev gulp-group-aggregate
```

Then, add it to your `gulpfile.js`:

```javascript
var path = require('path');
var File = require('vinyl');
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
  			return new File({
  				path: group + '.html',
  				contents: new Buffer(processFiles(files))
  			});
  		}
  	}));
    .pipe(gulp.dest('build/folder.txt'));
});
```

## API

gulp-group-aggregate is called with and object containing two functions: __group__ and __aggregate__.

### options.group(obj)

Receives an object from the stream and returns a string which represents its group. 

### options.aggregate(groupStr, objs)

Receives a group string as returned from __group__ calls and an array of all the objects associated with it. Returns a single object to be passed through the stream.

