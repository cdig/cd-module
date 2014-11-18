# Compatability
# Element.classList is IE10+

do ()->
	SCROLL_ANIMATION_SPEED = 500
	navbarButtons = []
	
	
	window.addEventListener "cdPagesReady", (e)->
		setupNavbar(e.detail.pages)
		setupEvents()
	
	
	setupNavbar = (pages)->
		navbar = document.createElement("cd-navbar")
		
		for page, pageIndex in pages
			navbarButton = makeNavbarButton(page, pageIndex)
			navbarButtons.push(navbarButton)
			navbar.appendChild(navbarButton)
		
		# Hack to make it come last in the list
		setTimeout ()->
			window.cdHUD.addElement(navbar)

	
	makeNavbarButton = (page, pageIndex)->
		navbarButton = document.createElement("cd-page-button")
		navbarButton.textContent = page.id.replace(/-/g, " ") # Hack: Let's try using the page ID as a title
		navbarButton.addEventListener("click", makeScrollHandler(page))
		return navbarButton
	
	makeScrollHandler = (page)->
		return ()->
			scrollPosition = document.body.scrollTop
			pageTop = page.offsetTop
			
			# Hack: As a convention, the first child of a page has a fair bit of margin.
			# We'll take that margin into account when animating to a page.
			# childStyle = @getComputedStyle page.querySelector ":first-child"
			# marginString = childStyle.getPropertyValue "margin-top"
			# margin = parseInt marginString.split("px")[0]
			# contentTop = pageTop + margin/2 # Adjust the factor as needed
			
			scrollTo(scrollPosition, pageTop - scrollPosition)
	
	
	setupEvents = ()->
		window.addEventListener("cdPageChange", handlePageChange)
	
	handlePageChange = (e)->
		prevIndex = e.detail.previousPageIndex
		pageIndex = e.detail.pageIndex
		
		enableNavbarButton(prevIndex, false) if prevIndex?
		enableNavbarButton(pageIndex, true)
	
	
	enableNavbarButton = (index, enable = true)->
		call = if enable then "add" else "remove"
		navbarButtons[index].classList[call]("current")

	
	easeInOutCubic = (t, b, c, d)->
		t /= d/2
		if (t < 1)
			return c/2*t*t*t + b
		else
			t -= 2
			return c/2*(t*t*t + 2) + b
	
	
	scrollTo = (startHeight, heightDiff)->
		return if heightDiff is 0
		
		startTime = null
		currentTime = 0
		duration = Math.sqrt Math.abs heightDiff * SCROLL_ANIMATION_SPEED
		
		animate = (systemTime)->
			startTime ?= systemTime
			currentTime = systemTime - startTime
			currentTime = duration if currentTime > duration
			height = easeInOutCubic currentTime, startHeight, heightDiff, duration
			document.body.scrollTop = height
			requestAnimationFrame animate if currentTime < duration
			
		requestAnimationFrame animate
