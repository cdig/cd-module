# Compatability Note:
# CustomEvent is non-IE — polyfill: https://developer.mozilla.org/en/docs/Web/API/CustomEvent
#	pageYOffset is an IE-compatable version of scrollY

do ()->
	PAGE_SELECTOR = "cd-page"
	pages = null
	currentPageIndex = null
	
	
	window.addEventListener "load", ()->
		setupPages()
		setupScrolling()
		firePagesReady()
		updateScroll()
	
	
	setupPages = ()->
		pages = document.querySelectorAll(PAGE_SELECTOR) # Mutation
	
	
	setupScrolling = ()->
		window.addEventListener("scroll", updateScroll)
	
	
	firePagesReady = ()->
		window.dispatchEvent new CustomEvent "cdPagesReady",
			detail:
				pages: pages
		
	
	updateScroll = ()->
		for page, pageIndex in pages
			if pageIsCurrent(page)
				if pageIndex isnt currentPageIndex
					newCurrentPage(page, pageIndex)
					break
	
	
	pageIsCurrent = (page)->
		pageTop = page.offsetTop
		pageBottom = page.offsetTop + page.offsetHeight
		scrollPosition = window.pageYOffset + document.body.clientHeight / 2
		return pageTop < scrollPosition and scrollPosition < pageBottom
	
	
	newCurrentPage = (newPage, newPageIndex)->
		prevPage = pages[currentPageIndex]
		prevPageIndex = currentPageIndex
		currentPageIndex = newPageIndex # Mutation
		dispatchPageChangeEvent(newPage, newPageIndex, prevPage, prevPageIndex)
	
	
	dispatchPageChangeEvent = (page, pageIndex, previousPage, previousPageIndex)->
		window.dispatchEvent new CustomEvent "cdPageChange",
			detail:
				page: page
				pageIndex: pageIndex
				previousPage: previousPage
				previousPageIndex: previousPageIndex
