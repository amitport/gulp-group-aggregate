# @module gulp-group-aggregate

_ = require('highland')

###
@callback groupBy
@param {*} obj - gets any object from the stream 
@returns {string} the group that obj belongs to
###

###
@callback aggregate
@param {string} group - the name of the group
@param {*[]} objects - and array of all the objects of the group
@returns {*} and aggregated object to passthrough the new stream
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
			_.map (grouped) -> _(aggregate(group, objects) for group, objects of grouped)
		,
			_.sequence()
	)