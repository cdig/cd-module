Take ["ComputePanelProperties", "OnScreen", "Panel", "PieceDrag", "PiecesSetup", "PieceAnimations", "ScaleAnimation", "load"], (ComputePanelProperties, OnScreen, Panel, PieceDrag, PiecesSetup, PieceAnimations, ScaleAnimation)->
  
  pitActivities = document.querySelectorAll("cd-activity[type='piece-it-together']")
  
  return unless pitActivities.length > 0
  
# THESE ARE DUMB AND SHOULD BE REFACTORED AWAY
  
  droppedItemCorrectly = (game)-> (item)->
    game.pieces.splice(game.pieces.indexOf(item), 1)
    if game.pieces.length is game.nWrongPieces
      gameComplete(game)
    else
      panelUpdate(game, true)
  
  getMatchingGroupPairNearItem = (game)-> (droppedItem)->
    for item in game.pieces when (item isnt droppedItem and item.matchGroup isnt "") #need to check for "" for match groups
      if item.matchGroup is droppedItem.matchGroup
        if droppedItem.drag.isCloseTo(item)
          return item
    return null

  
# Hey, it's a fake class instance!
  
  createGame = (element)->
    game =
      element: element
      activated: false
    game.pieces = PiecesSetup.makePieces(game.element, game)
    game.nWrongPieces = (piece for piece in game.pieces when piece.isWrong).length
    game.panel = Panel.makePanel(game.element, game)
    game.getMatchingGroupPairNearItem = getMatchingGroupPairNearItem(game)
    game.droppedItemCorrectly = droppedItemCorrectly(game)
    
    # Bugfix: Without the setTimeout, the activity might not initialize properly
    # if it is already on screen right as the code finishes loading.
    setTimeout ()->
      OnScreen game.element, attemptActivation game
    
    return game
    
    
# RESIZE
  
  handleResize = (game)->
    window.addEventListener("resize", ()-> resize(game))
  
  resize = (game)->
    panelUpdate(game, false)
    
    
# ACTIVATION
  
  attemptActivation = (game)-> (elm, visible)->
    if visible and not game.activated
      game.activated = true
      ComputePanelProperties(game.pieces, game.panel)
      for item in game.pieces
        PieceAnimations.introAnimation(item)
      # Only handle resizes after the intro animation begins, otherwise it might skip the animation
      handleResize(game)
    
# GAME STATE CHANGE
  
  gameComplete = (game)->
    
    # Hide any remaining "wrong" pieces
    for piece in game.pieces
      piece.element.style.visibility = "hidden"
    
    Panel.victoryDance(game.panel)
  
  panelUpdate = (game, animate = false)->
    ComputePanelProperties(game.pieces, game.panel)
    for item in game.pieces
      PieceAnimations.panelUpdate(item, animate)

  
# INITIALIZATION
  
  # We store all the games in an array, to prevent the GC from collecting them
  games = for pitActivity in pitActivities
    createGame(pitActivity)
