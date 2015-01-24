# Scroll To
# Animate the scroll to the desired position


Take "Ease", (Ease)->
  SCROLL_ANIMATION_SPEED = 500
  
  
  Make "ScrollTo", (endScroll)->
    startScroll = document.body.scrollTop
    return if startScroll is endScroll
    
    startTime = endTime = null
    duration = Math.sqrt(Math.abs((endScroll - startScroll) * SCROLL_ANIMATION_SPEED))
    
    animate = (currentTime)->
      startTime ?= currentTime
      endTime ?= startTime + duration
      document.body.scrollTop = Ease.cubic(currentTime, startTime, endTime, startScroll, endScroll, true)
      requestAnimationFrame(animate) if currentTime < duration
      
    requestAnimationFrame(animate)
