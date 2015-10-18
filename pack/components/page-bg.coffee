Take "load", ()->
  
  # TODO: Optimize for performance:
  ## Don't update positions if we can't see the background (remove move listeners, perhaps?)
  ## Don't update positions if the mouse is too far away from the background
  
  glow = document.querySelector("[page-bg-glow]")
  glowHalfWidth = glow.offsetWidth/2
  glowHalfHeight = glow.offsetHeight/2
  
  moveGlow = (e)->
    x = e.pageX - glowHalfWidth
    y = e.pageY - glowHalfHeight
    glow.style.transform = "translate(#{x}px, #{y}px)"
    true # TODO: document why we're returning true
  
  window.addEventListener "mousemove", moveGlow
  window.addEventListener "touchstart", moveGlow
  window.addEventListener "touchmove", moveGlow
