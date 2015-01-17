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
      lockedPage.classList.remove("locked-page") if lockedPage?
      lockedPage = null
      lockedPageIndex = null
      
      for page, index in Pages
        
        # It's less efficient, but easier to reason about, if we clear this class and then add it back if we need it
        page.classList.remove("hidden-by-locked-page")
        
        if lockedPage?
          page.classList.add("hidden-by-locked-page")
        else if pageShouldLock(page)
          lockedPage = page
          lockedPageIndex = index
          page.classList.add("locked-page")
      
      call() for call in callbacks
    
    
    onUpdate: (call)->
      callbacks.push(call)
      setTimeout ()->
        call()
  
  
  pageShouldLock = (page)->
    for activity in page.querySelectorAll("cd-activity")
      if Scoring.getActivityScore(activity) < 1
        return true
    return false
    
  
  Scoring.onUpdate ()->
    if lockedPage? and Scoring.getPageScore(lockedPage) >= 1
      PageLocking.update()
  
  
# SETUP
  
  PageLocking.update()
