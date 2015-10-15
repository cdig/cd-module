# Main Locking
# Find the first main with unearned points, and hide all the mains and pages after it.


Take ["Pages", "Scoring", "Params", "DOMContentLoaded"], (Pages, Scoring, Params)->
  mains = document.querySelectorAll "cd-main"
  lockingDisabled = Params.locking is "false"
  lockedMain = null
  callbacks = []
  
  
  Make "MainLocking", MainLocking =
    getLockedMain: ()->
      return lockedMain
    
    update: ()->
      updateLockedMain()
    
    onUpdate: (call)->
      callbacks.push call
  
  
# FUNCTIONS
  
  updateLockedMain = ()->
    if not (lockedMain? and mainShouldBeLocked(lockedMain))
      unlock()
      updateAllMains()
      runCallbacks()
  
  
  updateAllMains = ()->
    for main, index in mains
      setMainHidden(main, lockedMain?)
      if not lockedMain? and mainShouldBeLocked(main)
        setLockedMain(main, index)

  
  mainShouldBeLocked = (main)->
    return Scoring.getPageScore(main.parentElement) < 1 and not lockingDisabled
  
  
  unlock = ()->
    lockedMain.classList.remove("locked-main") if lockedMain?
    lockedMain = null
  
  
  setLockedMain = (main, index)->
    lockedMain = main
    main.classList.add("locked-main")
  
  
  setMainHidden = (main, hide)->
    if hide
      main.classList.add("hidden-by-locked-main")
    else
      main.classList.remove("hidden-by-locked-main")
  
  
  runCallbacks = ()->
    call() for call in callbacks
    
  
# INITIALIZATION
  
  Scoring.onUpdate(updateLockedMain)
  updateLockedMain()
