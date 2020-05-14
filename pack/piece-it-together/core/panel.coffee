Take ["Vector"], (Vector)->

  Make "Panel", Panel =
    makePanel: (game)->
      panelElement = document.createElement "piece-panel"
      game.element.insertBefore panelElement, game.element.firstChild
      return
        element: panelElement
        gameInstance: game

    x: (panel)->
      panel.element.getBoundingClientRect().left

    y: (panel)->
      panel.element.getBoundingClientRect().top

    width: (panel)->
      panel.element.offsetWidth

    height: (panel)->
      panel.element.offsetHeight

    position: (panel)->
      Vector.fromRectPos panel.element.getBoundingClientRect()

    victoryDance: (panel)->
      panel.element.setAttribute "message", "Correct!"
