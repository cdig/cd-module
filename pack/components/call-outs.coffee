Take "DOMContentLoaded", ()->
  
  minDistance = 30
  lastOpened = null
  
  
  setup = (callout)->
    label = document.createElement "call-out-label"
    label.innerHTML = callout.innerHTML
    callout.innerHTML = ""
    callout.appendChild label
    point = document.createElement "call-out-point"
    callout.appendChild point
    return callout._point = point
  
  
  open = (callout)->
    unless callout.hasAttribute "open"
      closeLastOpened()
      lastOpened = callout
      callout.setAttribute "open", true
      callout.setAttribute "seen", true
      callout.removeAttribute "closing"
  
  
  closeLastOpened = ()->
    if lastOpened?
      beginClosing lastOpened
      lastOpened = null

  
  beginClosing = (callout)->
    if callout.hasAttribute "open"
      callout.setAttribute "closing", true
      callout.removeAttribute "open"
      setTimeout finishClosing(callout), 200
  
  
  finishClosing = (callout)-> ()->
    if callout.hasAttribute "closing"
      callout.removeAttribute "closing"
  
  
  distanceToPoint = (point, x, y)->
    pos = point.getBoundingClientRect()
    dx = x - pos.left - pos.width/2
    dy = y - pos.top - pos.height/2
    Math.sqrt dx*dx + dy*dy
  
  
  calloutToOpen = (map, x, y)->
    closestCallout = null
    closestDistance = Infinity
    for point in map._points
      d = distanceToPoint point, x, y
      if d < closestDistance && d < minDistance
        closestCallout = point.parentNode
        closestDistance = d
    return closestCallout
  
  
  move = (map, x, y)->
    if closest = calloutToOpen map, x, y
      open closest
    else
      closeLastOpened()
    
  
  mousemove = (e)->
    move e.currentTarget, e.clientX, e.clientY
  
  
  touchmove = (e)->
    move e.currentTarget, e.touches[0].clientX, e.touches[0].clientY
  
  
  for map in document.querySelectorAll "cd-map"
    if map.querySelector("call-out")?
      map.addEventListener "touchmove", touchmove
      map.addEventListener "mousemove", mousemove
      map._points = for callout in map.querySelectorAll "call-out"
        setup callout
