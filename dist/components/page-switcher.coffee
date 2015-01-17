# Page Switcher
# A hovering UI element that allows quick access to a specific page


Take ["Pages", "SwitcherButton"], (Pages, SwitcherButton)->
  
  switcherOpen = false
  
  switcher = document.createElement("page-switcher")
  switcher.className = "closed"
  
  switcherButtons = for page, pageIndex in Pages
    switcher.appendChild(SwitcherButton(page, pageIndex))
  
  Take "PageLocking", (PageLocking)->
    PageLocking.onUpdate ()->
      for page, pageIndex in Pages
        if page.classList.contains("hidden-by-locked-page")
          switcherButtons[pageIndex].classList.add("locked")
        else
          switcherButtons[pageIndex].classList.remove("locked")
  
  document.body.appendChild(switcher)
  
  
  Make "PageSwitcher", PageSwitcher =
    open: ()->
      enableOpen(true) unless switcherOpen
      
    close: ()->
      enableOpen(false) if switcherOpen
    
    toggle: ()->
      if switcherOpen then PageSwitcher.close() else PageSwitcher.open()
    
    setPosition: (left, bottom)->
      bottom += 10
      switcher.style.left = "#{left}px"
      switcher.style["padding-bottom"] = "#{bottom}px"
  
  
  enableOpen = (enable = true)->
    switcherOpen = enable
    switcher.className = if enable then "open" else "closed"
    
    if enable
      setTimeout ()->
        window.addEventListener "click", clickOutside = ()->
          window.removeEventListener "click", clickOutside
          enableOpen(false)
