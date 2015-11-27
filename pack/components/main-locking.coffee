# Main Locking
# Find the first main with unearned points, and hide all the mains and pages after it.

# TODO: This code is very gross and imperative and stateful. It should be handled with gloves.


Take ["Pages", "Scoring", "Config", "DOMContentLoaded"], (Pages, Scoring, Config)->
  mains = document.querySelectorAll "cd-page > *"
  lockingEnabled = Config("locking") isnt "false"
  lockedMain = null
  hiddenMains = []
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
    return unless lockingEnabled
    if not (lockedMain? and shouldBeLocked(lockedMain))
      unlock()
      updateAllMains()
      runCallbacks()
  
  
  updateAllMains = ()->
    for main, index in mains
      setHidden(main, lockedMain?)
      if not lockedMain? and shouldBeLocked(main)
        setLocked(main, index)
  

  shouldBeLocked = (main)->
    activity = main.querySelector "cd-activity"
    return activity? and Scoring.getActivityScore(activity) < 1
  
  
  unlock = ()->
    lockedMain?.removeAttribute("main-locking-locked")
    lockedMain = null
    hiddenMains = []
  
  
  setLocked = (main, index)->
    lockedMain = main
    main.setAttribute("main-locking-locked", true)
  
  
  setHidden = (main, hide)->
    if hide
      main.setAttribute("main-locking-hidden", true)
      if main.parentElement isnt lockedMain.parentElement
        main.parentElement.setAttribute("main-locking-hidden", true)
    else
      main.removeAttribute("main-locking-hidden")
      main.parentElement.removeAttribute("main-locking-hidden")
  
  
  runCallbacks = ()->
    call() for call in callbacks
    
  
# INITIALIZATION
  
  Scoring.onUpdate(updateLockedMain)
  updateLockedMain()
