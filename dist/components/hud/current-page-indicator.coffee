Take ["cdHUD", "PageScrollWatcher", "PageTitle", "PageSwitcher"], (cdHUD, PageScrollWatcher, PageTitle, PageSwitcher)->
  
# LOCALS
  
  indicator = document.createElement("current-page-indicator")
  
  
# FUNCTIONS
  
  updateIndicator = ()->
    currentPage = PageScrollWatcher.getCurrentPage()
    indicator.textContent = PageTitle(currentPage)
  
  updateSwitcherPosition = ()->
    left = indicator.offsetLeft
    bottom = parseInt(window.getComputedStyle(indicator).height)
    PageSwitcher.setPosition(left, bottom)
  
  
# EVENT LISTENERS
  
  indicator.addEventListener("click", PageSwitcher.toggle)
  window.addEventListener("resize", updateSwitcherPosition)
  
  
# INITIALIZATION
  
  cdHUD.addElement(indicator)
  
  updateIndicator()
  updateSwitcherPosition()
  PageScrollWatcher.onPageChange(updateIndicator)
