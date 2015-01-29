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
      
      # According to cd-page.scss, the first child of a page has a fair bit of margin.
      # We'll take that margin into account when animating to a page.
      firstChild = page.querySelector(":first-child")
      childStyle = window.getComputedStyle(firstChild)
      marginString = childStyle.getPropertyValue("margin-top")
      margin = parseInt(marginString.split("px")[0])
      contentTop += margin/2 # Adjust the factor as needed
      
      ScrollTo(contentTop)
