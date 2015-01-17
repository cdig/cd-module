Take ["cdHUD", "PageScrollWatcher", "PageTitle", "PageSwitcher"], (cdHUD, PageScrollWatcher, PageTitle, PageSwitcher)->
  
# LOCALS
  
  indicator = document.createElement("current-page-indicator")
  
  
# FUNCTIONS
  
  update = ()->
    currentPage = PageScrollWatcher.getCurrentPage()
    indicator.textContent = PageTitle(currentPage)
  
  updatePosition = ()->
    left = indicator.offsetLeft
    bottom = parseInt(window.getComputedStyle(indicator).height)
    PageSwitcher.setPosition(left, bottom)
  
  
# EVENT LISTENERS
  
  indicator.addEventListener("click", PageSwitcher.toggle)
  window.addEventListener("resize", updatePosition)
  
  
# INITIALIZATION
  
  cdHUD.addElement(indicator)
  PageScrollWatcher.onPageChange(update)
  updatePosition()
  update()
