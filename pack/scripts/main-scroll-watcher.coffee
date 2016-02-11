Take "Mains", (Mains)->
  
  mainChangeCallbacks = []
  prevMainIndex = 0
  prevMain = Mains[0]
  
  
  Make "MainScrollWatcher", MainScrollWatcher =
    getCurrentMain: ()-> prevMain
    getCurrentMainIndex: ()-> prevMainIndex
    onMainChange: (callback)->
      mainChangeCallbacks.push callback
      
      # New in v2: We also run the callback immediately, because we're always on a main.
      setTimeout callback
  
  
  mainIsCurrent = (main)->
    mainTop = main.offsetTop
    mainBottom = main.offsetTop + main.offsetHeight
    top = document.body.scrollTop + document.body.parentNode.scrollTop
    scrollPosition = top + window.innerHeight / 2
    return mainTop < scrollPosition and scrollPosition < mainBottom
  
  
  mainChange = (main, mainIndex, previousMain, previousMainIndex)->
    for callback in mainChangeCallbacks
      callback()
  
  
  scrollHandlerFn = ()->
    for main, mainIndex in Mains
      if mainIsCurrent(main)
        if mainIndex isnt prevMainIndex
          prevMainIndex = mainIndex
          prevMain = main
          mainChange()
        return
  
  
  # INIT
  
  document.addEventListener "scroll", scrollHandlerFn
  scrollHandlerFn()
