# @module gulp-group-aggregate

_ = require('highland')
File = require('vinyl')
###
@callback groupBy
@param {*} obj - gets any object from the stream 
@returns {string} the group that obj belongs to
###

###
@callback aggregate
@param {string} group - the name of the group
@param {*[]} objects - and array of all the objects of the group
@returns {File.options} input for creating a new vinyl file (see https://github.com/wearefractal/vinyl)
###

###
@param {groupBy} 
@param {aggregate}
###
module.exports = ({group, aggregate}) -> 
	_.pipeline(
			# A bug in highland makes _.pipeline ignore it's first argument (https://github.com/caolan/highland/issues/68)
			# so we're just putting another empty pipeline here
			_.pipeline() 
		, 
			_.group(group)
		,
			_.map (grouped) -> _(new File(aggregate(group, objects)) for group, objects of grouped)
		,
			_.sequence()
	)