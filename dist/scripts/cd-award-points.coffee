# Map scoring events into the Scoring system

Take "Scoring", (Scoring)->
	window.addEventListener "cdAwardPoints", (e)->
		id = e.detail.id
		percent = e.detail.percent
		exact = e.detail.exact
		throw new Error("Activity events must provide an id.") unless id?
		throw new Error("Activity events must provide either a percent or exact: #{id}") unless percent? or exact?
		Scoring.addPoints(id, exact)
		Scoring.addScore(id, percent)
