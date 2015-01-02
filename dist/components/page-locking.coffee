# Page Locking
# Find the first page with unearned points, and hide all the pages after it.


Take ["Pages", "Scoring"], (Pages, Scoring)->
	lockedPage = null
	callbacks = []
	
	setTimeout ()->
		PageLocking.update()

	
	Make "PageLocking", PageLocking =
		getLockedPage: ()->
			return lockedPage
		
		
		update: ()->
			lockedPage?.classList.remove("locked-page")
			lockedPage = null
			
			for page in Pages
				
				# It's less efficient, but easier to reason about, if we clear this class and then add it back if we need it
				page.classList.remove("hidden-by-locked-page")
				
				if lockedPage?
					page.classList.add("hidden-by-locked-page")
				else if pageShouldLock(page)
					lockedPage = page
					page.classList.add("locked-page")
			
			call(lockedPage) for call in callbacks
		
		
		onUpdate: (callback)->
			callbacks.push(callback)
	
	
	pageShouldLock = (page)->
		for activity in page.querySelectorAll("cd-activity")
			if Scoring.getActivityScore(activity.id) < 1
				return true
		return false
		
	
	Scoring.onUpdate ()->
		if Scoring.getPageScore(lockedPage) >= 1
			PageLocking.update()
