Take ["DOOM", "DOMContentLoaded"], (DOOM)->

  minDistance = 30
  lastOpened = null


  setup = (callout)->
    label = document.createElement "call-out-label"
    labelContent = document.createElement "call-out-label-content"
    labelContent.innerHTML = callout.innerHTML
    callout._horizontal = callout.hasAttribute("left") or callout.hasAttribute("right")
    callout._labelContent = labelContent
    callout.innerHTML = ""
    point = document.createElement "call-out-point"
    label.appendChild labelContent
    callout.appendChild label
    callout.appendChild point
    return callout._point = point


  open = (callout)->
    unless callout.hasAttribute "open"
      closeLastOpened()
      lastOpened = callout
      callout.setAttribute "open", true
      callout.setAttribute "seen", true
      callout.removeAttribute "closing"
      changeSideIfOverhanging callout
      slideIfOverhanging callout


  changeSideIfOverhanging = (callout)->
    return unless callout._horizontal
    bounds = callout.getBoundingClientRect()
    if bounds.right > window.innerWidth
      callout.removeAttribute "right"
      DOOM callout, left: ""
    else if bounds.left < 0
      callout.removeAttribute "left"
      DOOM callout, right: ""


  slideIfOverhanging = (callout)->
    bounds = callout.getBoundingClientRect()
    xOverhang = if bounds.right > window.innerWidth
      bounds.right - window.innerWidth
    else if bounds.left < 0
      bounds.left
    if xOverhang?
      DOOM callout._labelContent, transform: "translateX(#{-xOverhang}px)"


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
      DOOM callout._labelContent, transform: null


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


  mousemove = (map)-> (e)->
    return if e.touches?
    move map, e.clientX, e.clientY


  touchend = (map)-> (e)->
    move map, e.touches[0].clientX, e.touches[0].clientY


  window.addEventListener "touchstart", closeLastOpened

  for map in document.querySelectorAll "cd-map"
    if map.querySelector("call-out")?
      map.addEventListener "mousemove", mousemove map
      map.addEventListener "touchend", touchend map
      map._points = for callout in map.querySelectorAll "call-out"
        setup callout
