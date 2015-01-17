# Page Locking
# Find the first page with unearned points, and hide all the pages after it.


Take ["Pages", "Scoring"], (Pages, Scoring)->
  lockedPage = null
  lockedPageIndex = null
  callbacks = []
  
  
  Make "PageLocking", PageLocking =
    getLockedPage: ()->
      return lockedPage
    
    getLockedPageIndex: ()->
      return lockedPageIndex
      
    update: ()->
      updateLockedPage()
    
    onUpdate: (call)->
      callbacks.push(call)
  
  
# FUNCTIONS
  
  updateLockedPage = ()->
    if not (lockedPage? and pageShouldBeLocked(lockedPage))
      unlock()
      updateAllPages()
      runCallbacks()
  
  
  updateAllPages = ()->
    for page, index in Pages
      setPageHidden(page, lockedPage?)
      if not lockedPage? and pageShouldBeLocked(page)
        setLockedPage(page, index)
  
  
  pageShouldBeLocked = (page)->
    return Scoring.getPageScore(page) < 1
  
  
  unlock = ()->
    lockedPage.classList.remove("locked-page") if lockedPage?
    lockedPage = null
    lockedPageIndex = null
  
  
  setLockedPage = (page, index)->
    lockedPage = page
    lockedPageIndex = index
    page.classList.add("locked-page")
  
  
  setPageHidden = (page, hide)->
    if hide
      page.classList.add("hidden-by-locked-page")
    else
      page.classList.remove("hidden-by-locked-page")
  
  
  runCallbacks = ()->
    call() for call in callbacks
    
  
# INITIALIZATION
  
  Scoring.onUpdate(updateLockedPage)
  updateLockedPage()
