Take "load", ()->
	open = (callout)->
		callout.setAttribute("open", true)
		callout.setAttribute("seen", true)
		callout.removeAttribute("closing")
	
	beginClosing = (callout)->
		unless callout.hasAttribute("closing")
			callout.setAttribute("closing", true)
			setTimeout((()-> finishClosing(callout)), 200)
	
	finishClosing = (callout)->
		if callout.hasAttribute("closing")
			callout.removeAttribute("open")
			callout.removeAttribute("closing")
	
	extractLabel = (callout)->
		label = document.createElement("call-out-label")
		label.innerHTML = callout.innerHTML
		callout.innerHTML = ""
		callout.appendChild(label)
	
	makePoint = (callout)->
		point = document.createElement("call-out-point")
		point.addEventListener("mouseover", (e)-> open(callout))
		point.addEventListener("mouseout", (e)-> beginClosing(callout))
		callout.appendChild(point)


# SETUP
	
	for callout in document.querySelectorAll("call-out")
		extractLabel(callout) # Gross Mutation
		makePoint(callout) # Less gross Mutation
	

# SCORING
	
	# If we have scoring, wrap the open() function with points
	Take "Scoring", (Scoring)->
		
		# Store the original open function so we can still refer to it
		oldOpen = open
		
		allHaveBeenSeen = (callouts)->
			for callout in callouts
				return false unless callout.hasAttribute("seen")
			return true
		
		open = (callout)->
			shouldAwardPoint = not callout.hasAttribute("seen")
			
			oldOpen(callout)
			
			if allHaveBeenSeen(callout.parentElement.querySelectorAll("call-out"))
				Scoring.addScore(callout, 1)
			else if shouldAwardPoint
				Scoring.addPoints(callout, 1)
