# Compatability:
#	pageYOffset is an IE-compatable version of scrollY


Take ["Pages", "PageLocking", "load"], (Pages, PageLocking)->
	
# STATE
	lastSetPosition = 0
	lockedPage = null
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
		show: (text, iconText, fast = false)->
			scrollHintTab.textContent = text
			if iconText?
				scrollHintTab.setAttribute("icon-text", iconText)
			else
				scrollHintTab.removeAttribute("icon-text")
			lastSetPosition = window.pageYOffset
			show(fast)
			
			
		hide: ()->
			hide()
	

# PRIVATE
	
	show = (fast)->
		if not showing
			showing = true
			scrollHint.setAttribute("showing", true)
			
			if fast
				scrollHint.setAttribute("fast", true)
			else
				scrollHint.removeAttribute("fast")
		
	
	hide = ()->
		if showing
			showing = false
			scrollHint.removeAttribute("showing")
	
	
	showBeginHint = ()->
		ScrollHint.show("Scroll down to begin", "⬇︎")
	
	
	showLockedHint = ()->
		if lockedPage?
			ScrollHint.show("Complete the activity on this page", "!", true)

	
# EVENT HANDLING
	
	update = ()->
		scrollRange = document.body.scrollHeight - window.innerHeight
		nearTop = window.pageYOffset < deadband
		nearEnd = window.pageYOffset + deadband >= scrollRange
		moved = Math.abs(window.pageYOffset - lastSetPosition) > deadband
		
		if showing
			hide() if moved and not (nearTop or nearEnd)
		else
			showBeginHint() if nearTop
			showLockedHint() if nearEnd
	
	
# INIT
	
	if Pages.length > 1
		
		update()
		
		window.addEventListener("scroll", update)
		window.addEventListener("resize", update)
		scrollHintTab.addEventListener("click", hide)
		
		PageLocking.onUpdate (newLockedPage)->
			if lockedPage?
				ScrollHint.show("Scroll down to continue", "✓")
			lockedPage = newLockedPage
