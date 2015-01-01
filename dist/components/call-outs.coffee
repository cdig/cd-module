Take "load", ()->
	
	show = (callout)->
		callout.setAttribute("open", true)
		callout.setAttribute("seen", true)
	
	hide = (callout)->
		callout.removeAttribute("open")
	
	extractLabel = (callout)->
		label = document.createElement("call-out-label")
		label.innerHTML = callout.innerHTML
		callout.innerHTML = ""
		callout.appendChild(label)
	
	makePoint = (callout)->
		point = document.createElement("call-out-point")
		point.addEventListener("mouseover", (e)-> show(callout))
		point.addEventListener("mouseout", (e)-> hide(callout))
		callout.appendChild(point)


# SETUP
	
	for callout in document.querySelectorAll("call-out")
		extractLabel(callout) # Gross Mutation
		makePoint(callout) # Less gross Mutation
	

# SCORING
	
	# If we have scoring, wrap the show() function with points
	Take "Scoring", (Scoring)->
		
		# Store the original show function so we can still refer to it
		oldShow = show
		
		allHaveBeenSeen = (callouts)->
			for callout in callouts
				return false unless callout.hasAttribute("seen")
			return true
		
		show = (callout)->
			Scoring.addPoints(callout, 1) unless callout.hasAttribute("seen")
				
			oldShow(callout)
			
			if allHaveBeenSeen(callout.parentElement.querySelectorAll("call-out"))
				Scoring.addScore(callout, 1)
