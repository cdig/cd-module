Take "DOMContentLoaded", ()->
  observer = null
  fallbackUpdateRequested = false
  items = []


  fallbackUpdate = ()->
    fallbackUpdateRequested = false
    for item in items
      rect = item.elm.getBoundingClientRect()
      elemTop = rect.top
      elemBottom = rect.bottom
      isVisible = rect.top < window.innerHeight and rect.bottom > 0
      item.cb item.elm, isVisible


  requestFallbackUpdate = ()->
    return if fallbackUpdateRequested
    fallbackUpdateRequested = true
    requestAnimationFrame fallbackUpdate


  observerUpdate = (entries)->
    for entry in entries
      for item in items when item.elm is entry.target
        item.cb item.elm, entry.isIntersecting


  setup = ()->
    if IntersectionObserver?
      observer = new IntersectionObserver observerUpdate
    else
      window.addEventListener "scroll", requestFallbackUpdate


  Make "OnScreen", (elm, cb)->
    setup() if items.length is 0
    items.push {elm: elm, cb: cb}
    if observer?
      observer.observe elm
    else
      setTimeout requestFallbackUpdate, 50
