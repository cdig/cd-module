# Switcher Button
# Code for the page buttons inside the Page Switcher.

Take ["ScrollTo", "PageTitle"], (ScrollTo, PageTitle)->
  
  Make "SwitcherButton", (page, pageIndex)->
    button = document.createElement("a")
    button.className = "switcher-button"
    button.textContent = PageTitle(page)
    button.addEventListener("click", makeScrollHandler(page, button))
    return button
    
    
  makeScrollHandler = (page, button)->
    return (e)->
      return if button.classList.contains("locked")
      
      scrollPosition = document.body.scrollTop
      contentTop = page.offsetTop
      
      # Take the padding into account when animating to a page.
      style = window.getComputedStyle(page)
      paddingString = style.getPropertyValue("padding-top")
      padding = parseInt(paddingString)
      contentTop += padding # Adjust the factor as needed
      
      # Try to center the page
      pageHeight = page.clientHeight - padding*2
      contentTop -= Math.max((window.innerHeight - pageHeight)/2, 20)
      
      ScrollTo(contentTop)
