# Compatability:
#	pageYOffset is an IE-compatable version of scrollY


Take ["PageLocking", "load"], (PageLocking)->

# STATE
	lastSetPosition = 0
	lockedPage = null
	aboutToHide = false
	showing = false
	deadband = 50
	icon = null

	
# ELEMENTS
	scrollHint = document.createElement("scroll-hint")
	scrollHintTab = document.createElement("scroll-hint-tab")
	scrollHint.appendChild(scrollHintTab)
	document.body.appendChild(scrollHint)
	
	
# PUBLIC
	
	Make "ScrollHint", ScrollHint =
		show: (text, iconText)->
			scrollHintTab.textContent = text
			if iconText?
				scrollHintTab.setAttribute("icon-text", iconText)
			else
				scrollHintTab.removeAttribute("icon-text")
			lastSetPosition = window.pageYOffset
			show()
			
			
		hide: ()->
			prepareToHide()
	
	
	show = ()->
		if not showing
			showing = true
			scrollHint.setAttribute("showing", true)
	
	
	prepareToHide = ()->
		if showing and not aboutToHide
			aboutToHide = true
			setTimeout(hide, 100)
	
	
	hide = ()->
		if aboutToHide and showing
			showing = false
			scrollHint.removeAttribute("showing")
		aboutToHide = false
		
	
# EVENT HANDLING
	
	do scrollUpdate = ()->
		tallEnoughToHaveScrollHints = document.body.scrollHeight > window.innerHeight
		scrollMax = document.body.scrollHeight - window.innerHeight
		
		if showing
			if window.pageYOffset < 0 or window.pageYOffset >= scrollMax
				return
			if Math.abs(window.pageYOffset - lastSetPosition) > deadband
				prepareToHide()
			else if not tallEnoughToHaveScrollHints
				prepareToHide()
		
		else if tallEnoughToHaveScrollHints
			if window.pageYOffset < deadband
				ScrollHint.show("Scroll down to begin", "⬇︎")
			else if window.pageYOffset + deadband >= scrollMax
				if lockedPage?
					ScrollHint.show("Complete the activity on this page", "!")
	
	
# EVENT LISTENING
	
	window.addEventListener("scroll", scrollUpdate)
	window.addEventListener("resize", scrollUpdate)
	scrollHintTab.addEventListener("click", prepareToHide)
	
	
# SYSTEM EVENTS
	
	PageLocking.onUpdate (newLockedPage)->
		if lockedPage?
			ScrollHint.show("Scroll down to continue", "✓")
		lockedPage = newLockedPage
