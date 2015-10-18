Take "load", ()->
  MOUSE_RATE = .01
  
  bg = document.querySelector(".fancybg .bg")
  glow = document.querySelector(".glow")
  glowHalfWidth = glow.offsetWidth/2
  glowHalfHeight = glow.offsetHeight/2
  
  positionBg = (x,y)->
    bg.style.backgroundPosition = "#{x}px #{y}px";
  
  translateBg = (x,y)->
    bg.style.transform = "translate(#{x}px, #{y}px) scale(1.05)";
  
  offsetGlow = (x, y)->
    glow.style.left = x + "px"
    glow.style.top = y + "px"
    glow.style.visibility = "visible"
  
  moveBg = (e)->
    x = (e.screenX - screen.width/2) * MOUSE_RATE
    y = (e.screenY - screen.height/2) * MOUSE_RATE
    translateBg(x,y)
    true
  
  moveGlow = (e)->
    x = e.pageX - glowHalfWidth
    y = e.pageY - glowHalfHeight
    offsetGlow(x, y)
    true

  orientBg = (e)->
    x = e.gamma
    y = e.beta
    positionBg(x,y)
    true
  
  # SETUP ##########################################################################################
  positionBg(0,0)
  translateBg(0,0)
  
  window.addEventListener "mousemove", moveBg
  window.addEventListener "mousemove", moveGlow
  window.addEventListener "touchstart", moveGlow
  window.addEventListener "touchmove", moveGlow
  window.addEventListener "deviceorientation", orientBg
