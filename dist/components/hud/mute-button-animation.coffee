

Take ["Ease", "UnitsConverter"], (Ease, UnitsConverter)->
  Make "MuteAnimation", (graphic, mute)->
    pixelSize = UnitsConverter.getEmPixels()
    currentTime = null
    elapsedTime = 0
    animateFirst = false
    animateSecond = false
    animateThird = false
    endAnimation = false
    
    draw = (time)->
      #this function creates a closure where we animate a particular part of the mute element
      #it is called once for each part of the mute button
      animateElement = (element)->
        transformCurrentTime = null
        animDuration = 0.3 #how long the animation takes in total
        elapsedTransformTime = 0
        drawTransform = (tTime)->
          transformCurrentTime = tTime if not transformCurrentTime?
          dTTime = (tTime - transformCurrentTime)/1000
          transformCurrentTime = tTime
          elapsedTransformTime += dTTime
          scaleVal = Ease.quadratic(elapsedTransformTime, 0, animDuration)
          if mute #if we're muting the control we scale backwards from 1 to 0
            scaleVal = 1.0 - scaleVal
          transX = pixelSize
          transY = pixelSize * 1.5
          element.setAttribute('transform', "translate(#{transX}, #{transY}) scale(#{scaleVal}, #{scaleVal}) translate(-#{transX}, -#{transY})")
          if (elapsedTransformTime - animDuration) < 0 #
            requestAnimationFrame(drawTransform)
        requestAnimationFrame(drawTransform)
      currentTime = time if not currentTime?

      dT = (time - currentTime)/1000
      currentTime = time
      elapsedTime += dT

      #starts the timing for animating all of the elements
      #we ensure to set flags once each element's animation has been triggered
      if elapsedTime > 0.1 and not animateFirst
        animateFirst = true
        selector = if mute then graphic.querySelector("path:nth-child(1)") else graphic.querySelector("path:nth-child(3)") 
        animateElement(selector)
      if elapsedTime > 0.2 and not animateSecond
        animateSecond = true
        animateElement(graphic.querySelector("path:nth-child(2)"))
      if elapsedTime > 0.3 and not animateThird
        animateThird = true
        selector = if mute then graphic.querySelector("path:nth-child(3)") else graphic.querySelector("path:nth-child(1)")
        animateElement(selector) 
        endAnimation = true
      if not endAnimation
        requestAnimationFrame(draw)
    requestAnimationFrame(draw)