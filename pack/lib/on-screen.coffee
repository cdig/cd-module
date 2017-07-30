Take "DOMContentLoaded", ()->
  requested = false
  items = []
  
  update = ()->
    requested = false
    for item in items
      rect = item.elm.getBoundingClientRect()
      elemTop = rect.top
      elemBottom = rect.bottom
      isVisible = rect.top < window.innerHeight and rect.bottom > 0
      item.cb item.elm, isVisible
  
  requestUpdate = ()->
    return if requested
    requested = true
    requestAnimationFrame update
  
  window.addEventListener "scroll", requestUpdate
  
  Make "OnScreen", (elm, cb)->
    items.push {elm: elm, cb: cb}
    setTimeout requestUpdate, 50
