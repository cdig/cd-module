
loadScrollRegionsTest = ()->
	scrollRegions = document.querySelectorAll('[scrollStart]')
	console.log "this worked"
	for scrollRegion in scrollRegions
		console.log "hey"
		scrollRegion.addEventListener "scrollPercentage", (e)->
			console.log "we got a scroll region with a value " + e.detail.value
	document.body.addEventListener "scrollPercentage", (e)->
		console.log "and our position on the body is " + e.detail.value
window.addEventListener "load", loadScrollRegionsTest, false