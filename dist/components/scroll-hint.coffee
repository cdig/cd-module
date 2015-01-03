# Compatability:
#	pageYOffset is an IE-compatable version of scrollY


Take ["Pages", "PageLocking", "load"], (Pages, PageLocking)->
	DELAY_BEFORE_TOP_HINT = 4000
	
	
# STATE
	lastSetPosition = 0
	lockedPage = null
	aboutToHide = false
	aboutToShowTopHint = false
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
	

# PRIVATE
	
	show = ()->
		if not showing
			showing = true
			scrollHint.setAttribute("showing", true)
	
	
	prepareToHide = ()->
		if showing and not aboutToHide
			aboutToHide = true
			aboutToShowTopHint = false
			setTimeout(hide, 100)
	
	
	hide = ()->
		if aboutToHide and showing
			showing = false
			scrollHint.removeAttribute("showing")
		aboutToHide = false
	
	
	showHints = (scrollMax)->
		atTop = window.pageYOffset < deadband
		atEnd = window.pageYOffset + deadband >= scrollMax
		
		switch
			when atTop then showTopHint()
			when atEnd then showEndHint()
			else
				aboutToShowTopHint = false
		
	
	showTopHint = ()->
		unless aboutToShowTopHint
			aboutToShowTopHint = true
			setTimeout(doShowTopHint, DELAY_BEFORE_TOP_HINT)
	
	
	doShowTopHint = ()->
		if aboutToShowTopHint
			aboutToShowTopHint = false
			ScrollHint.show("Scroll down to begin", "⬇︎")
	
	
	showEndHint = ()->
		if lockedPage?
			ScrollHint.show("Complete the activity on this page", "!")

	
# EVENT HANDLING
	
	scrollUpdate = ()->
		tallEnoughToHaveScrollHints = Pages.length > 1
		scrollMax = document.body.scrollHeight - window.innerHeight
		
		if showing
			if window.pageYOffset < 0 or window.pageYOffset >= scrollMax
				return
			if Math.abs(window.pageYOffset - lastSetPosition) > deadband
				prepareToHide()
			else if not tallEnoughToHaveScrollHints
				prepareToHide()
		
		else if tallEnoughToHaveScrollHints
			showHints(scrollMax)
	
	
# EVENT LISTENING
	
	window.addEventListener("scroll", scrollUpdate)
	window.addEventListener("resize", scrollUpdate)
	scrollHintTab.addEventListener("click", prepareToHide)
	
	
# SYSTEM EVENTS
	
	PageLocking.onUpdate (newLockedPage)->
		if lockedPage?
			ScrollHint.show("Scroll down to continue", "✓")
		lockedPage = newLockedPage


# INIT
	
	scrollUpdate()
