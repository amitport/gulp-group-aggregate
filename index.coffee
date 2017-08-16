# @module gulp-group-aggregate

_ = require('highland')
File = require('vinyl')
Promise = require('bluebird')
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
	aggregate = Promise.method(aggregate)
	_.pipeline(
			_.group(group)
		,
			_.map (grouped) ->
				_(
					_(aggregate(group, objects).then((aggregated) ->	aggregated && new File(aggregated))) for group, objects of grouped
				).sequence()
		,
			_.sequence()
		,
			_.filter((file) -> file)
	)