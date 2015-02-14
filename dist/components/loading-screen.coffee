do ()->
  gearId  = setTimeout (()-> document.body.setAttribute("show-loading-screen-gear", "")), 1000
  titleId = setTimeout (()-> document.body.setAttribute("show-loading-screen-title", "")), 6000
  slowId  = setTimeout (()-> document.body.setAttribute("show-loading-screen-slow", "")), 12000
  checkId = setTimeout (()-> document.body.setAttribute("show-loading-screen-check", "")), 24000
  
  Take "load", ()->
    window.clearTimeout(gearId)
    window.clearTimeout(titleId)
    window.clearTimeout(slowId)
    window.clearTimeout(checkId)
    
    document.body.removeAttribute("show-loading-screen-gear")
    document.body.removeAttribute("show-loading-screen-title")
    document.body.removeAttribute("show-loading-screen-slow")
    document.body.removeAttribute("show-loading-screen-check")
    
    document.body.setAttribute("hide-loading-screen", "")
    
    removeLoadingScreen = ()->
      loadingScreen = document.querySelector("loading-screen")
      loadingScreen?.parentNode?.removeChild?(loadingScreen)
      document.body.removeAttribute("hide-loading-screen")
    
    setTimeout(removeLoadingScreen, 1000)
