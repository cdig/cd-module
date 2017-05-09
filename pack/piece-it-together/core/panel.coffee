Take ["Vector", "Curry", "load"], (Vector, Curry)->
  dot = Curry 2, (prop, obj)->
    return obj[prop]

  dotX = dot "x"
  dotY = dot "y"
  
  Make "Panel", Panel =
    makePanel: (gameElement, gameInstance)->
      panelElement = document.createElement("piece-panel")
      gameElement.insertBefore(panelElement, gameElement.firstChild)
      return {element:panelElement, gameInstance: gameInstance}
  
    x: (panel)->
      return panel.element.getBoundingClientRect().left#@panel.element.offsetLeft
    
    y: (panel)-> 
      return panel.element.getBoundingClientRect().top #@panel.element.offsetTop
    
    width: (panel)->
      return panel.element.offsetWidth
    
    height: (panel)->
      return panel.element.offsetHeight
    
    position: (panel)->
      return Vector.fromRectPos(panel.element.getBoundingClientRect())
  
    victoryDance: (panel)->
      panel.element.setAttribute("message", "Good job!")
  
