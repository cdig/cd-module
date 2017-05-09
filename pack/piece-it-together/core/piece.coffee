Take ["Vector", "Panel", "Transformer", "Transitioner", "load"], (Vector, Panel, Transformer, Transitioner)->
  
  Make "Piece", Piece =
    create: (element, original, gameInstance)->
      obj =
        element: element
        original: original
        game: gameInstance
        matchGroup: element.getAttribute("piece")
        transformer: Transformer.create(element)
        transitioner: Transitioner.create(element)
        scale: 1
        panelScale: 1
        panelPosition: null
        dragPosition: null
        moved: false #may not need.
      
      obj.isWrong = obj.matchGroup is "wrong"
      
      return obj
