# ScrollHint
# A little popup at the bottom of the window that gives users hints about whether or not to scroll.
#
# Compatability:
# pageYOffset is an IE-compatable version of scrollY


Take ["DOMContentLoaded"], ()->

# STATE
  lastSetPosition = 0
  showing = false
  suppressed = false
  deadband = 20
  icon = null

  
# ELEMENTS
  scrollHint = document.createElement("scroll-hint")
  scrollHintTab = document.createElement("scroll-hint-tab")
  scrollHint.appendChild(scrollHintTab)
  document.body.appendChild(scrollHint)
  
  mains = document.querySelectorAll "cd-main"
  
# PRIVATE
  
  show = (fast)->
    if not showing and not suppressed
      showing = true
      scrollHint.setAttribute("showing", true)
      
      if fast
        scrollHint.setAttribute("fast", true)
      else
        scrollHint.removeAttribute("fast")
    
  
  hide = ()->
    if showing
      showing = false
      scrollHint.removeAttribute("showing")
  
  
  showBeginHint = ()->
    ScrollHint.show("Scroll down to begin", "⇣")
  
  
# EVENT HANDLING
  
  updateScroll = ()->
    
    # Safari/Chrome scroll <body>, Firefox scrolls <html>
    scrollTop = document.body.scrollTop + document.body.parentNode.scrollTop
    
    scrollRange = document.body.scrollHeight - window.innerHeight
    nearTop = scrollTop < deadband
    nearEnd = scrollTop + deadband >= scrollRange
    moved = Math.abs(scrollTop - lastSetPosition) > deadband
    
    if showing
      hide() if moved and not (nearTop or nearEnd)
    else
      showBeginHint() if nearTop


# PUBLIC
  
  Make "ScrollHint", ScrollHint =
    show: (text, iconText, fast = false)->
      scrollHintTab.textContent = text
      if iconText?
        scrollHintTab.setAttribute("icon-text", iconText)
      else
        scrollHintTab.removeAttribute("icon-text")
      lastSetPosition = window.pageYOffset
      show(fast)
      
    hide: ()->
      hide()
    
    suppress: (enable = true)->
      suppressed = enable
      if suppressed then hide() else updateScroll()
      
  
# INIT
  
  if mains.length > 1
    window.addEventListener("scroll", updateScroll)
    window.addEventListener("resize", updateScroll)
    scrollHintTab.addEventListener("click", hide)
    updateScroll()
