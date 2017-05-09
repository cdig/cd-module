Take "DOMContentLoaded", ()->
  
  wasTouched = false
  lastOpened = null
  
  
  open = (callout)->
    unless callout.hasAttribute("open")
      closeLastOpened()
      lastOpened = callout
      callout.setAttribute("open", true)
      callout.setAttribute("seen", true)
      callout.removeAttribute("closing")
  
  
  beginClosing = (callout)->
    if callout.hasAttribute("open") and not callout.hasAttribute("closing")
      callout.setAttribute("closing", true)
      callout.removeAttribute("open")
      setTimeout((()-> finishClosing(callout)), 200)
  
  
  finishClosing = (callout)->
    if callout.hasAttribute("closing")
      callout.removeAttribute("closing")
  
  
  closeLastOpened = ()->
    if lastOpened?
      beginClosing(lastOpened)
      lastOpened = null
  
  
  touchOpen = (callout)->
    wasTouched = true
    setTimeout(clearTouched, 333)
    open(callout)
  
  
  clearTouched = ()->
    wasTouched = false
  
  
  extractLabel = (callout)->
    label = document.createElement("call-out-label")
    label.innerHTML = callout.innerHTML
    callout.innerHTML = ""
    callout.appendChild(label)
  
  
  makePoint = (callout)->
    point = document.createElement("call-out-point")
    callout.appendChild(point)
    point.addEventListener("touchstart", (e)-> handleTouchStart(e, callout))
    point.addEventListener("mouseover", (e)-> handleMouseOver(e, callout))
    point.addEventListener("mouseout", (e)-> handleMouseOut(e, callout))


# EVENT HANDLING
  
  handleTouchStart = (e, callout)->
    e.preventDefault()
    touchOpen(callout)
  
    
  handleMouseOver = (e, callout)->
    e.preventDefault()
    open(callout) unless wasTouched
    
    
  handleMouseOut = (e, callout)->
    e.preventDefault()
    beginClosing(callout)
  
  
  handleBodyTouch = (e)->
    closeLastOpened() unless e.target.matches("call-out-point")
  
  
# SETUP
  
  for callout in document.querySelectorAll("call-out")
    extractLabel(callout) # Gross Mutation
    makePoint(callout) # Less gross Mutation
  
  document.body.addEventListener("touchstart", handleBodyTouch)
