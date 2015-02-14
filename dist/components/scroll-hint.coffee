# ScrollHint
# A little popup at the bottom of the window that gives users hints about whether or not to scroll.
#
# Compatability:
#	pageYOffset is an IE-compatable version of scrollY


Take ["Pages", "PageLocking", "load"], (Pages, PageLocking)->
  
# STATE
  lastSetPosition = 0
  locked = false
  showing = false
  suppressed = false
  deadband = 20
  icon = null

  
# ELEMENTS
  scrollHint = document.createElement("scroll-hint")
  scrollHintTab = document.createElement("scroll-hint-tab")
  scrollHint.appendChild(scrollHintTab)
  document.body.appendChild(scrollHint)
  
  
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
    unless PageLocking.getLockedPageIndex() is 0
      ScrollHint.show("Scroll down to begin", "⇣")
  
  
  showLockedHint = ()->
    if locked
      ScrollHint.show("Complete the activity on this page", "!", true)

  
# EVENT HANDLING
  
  updateScroll = ()->
    scrollRange = document.body.scrollHeight - window.innerHeight
    nearTop = window.pageYOffset < deadband
    nearEnd = window.pageYOffset + deadband >= scrollRange
    moved = Math.abs(window.pageYOffset - lastSetPosition) > deadband
    
    if showing
      hide() if moved and not (nearTop or nearEnd)
    else
      showBeginHint() if nearTop
      showLockedHint() if nearEnd

  
  updateLockedPage = ()->
    if locked
      ScrollHint.show("Scroll down to continue", "✓")
    locked = PageLocking.getLockedPage()?
  
  
# INIT
  
  if Pages.length > 1
    window.addEventListener("scroll", updateScroll)
    window.addEventListener("resize", updateScroll)
    scrollHintTab.addEventListener("click", hide)
    PageLocking.onUpdate(updateLockedPage)
    updateLockedPage()
    updateScroll()
