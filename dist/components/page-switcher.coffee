# Page Switcher
# A hovering UI element that allows quick access to a specific page


Take ["Pages", "SwitcherButton", "PageLocking"], (Pages, SwitcherButton, PageLocking)->

# LOCALS & ELEMENTS
  
  switcherOpen = false
  
  switcher = document.createElement("page-switcher")
  switcher.className = "closed"
  
  switcherButtons = for page, pageIndex in Pages
    switcher.appendChild(SwitcherButton(page, pageIndex))
  
  document.body.appendChild(switcher)
  
  
# PUBLIC API
  
  Make "PageSwitcher", PageSwitcher =
    open: ()->
      setOpen(true) unless switcherOpen
      
    close: ()->
      setOpen(false) if switcherOpen
    
    toggle: ()->
      setOpen(!switcherOpen)
    
    setPosition: (left, bottom)->
      bottom += 10
      switcher.style.left = "#{left}px"
      switcher.style["padding-bottom"] = "#{bottom}px"
  
  
 # FUNCTIONS
  
  clickOutside = ()->
    window.removeEventListener("click", clickOutside)
    setOpen(false)
  
  
  setOpen = (open = true)->
    switcherOpen = open
    switcher.className = if switcherOpen then "open" else "closed"
    
    if switcherOpen
      setTimeout ()-> # Wait until the click (that opened the switcher) is done
        window.addEventListener("click", clickOutside)
  
  
  updateLockedPages = ()->
    for page, pageIndex in Pages
      if page.classList.contains("hidden-by-locked-page")
        switcherButtons[pageIndex].classList.add("locked")
      else
        switcherButtons[pageIndex].classList.remove("locked")
  
  
# INITIALIZATION
  
  PageLocking.onUpdate(updateLockedPages)
