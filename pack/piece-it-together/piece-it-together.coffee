Take ["ComputePanelProperties", "Curry", "MainScrollWatcher","Panel", "PieceDrag", "PiecesSetup", "PieceAnimations","ScaleAnimation", "Scoring",  "load"], (ComputePanelProperties, Curry, MainScrollWatcher, Panel, PieceDrag, PiecesSetup,PieceAnimations,ScaleAnimation, Scoring)->
  
  pitActivities = document.querySelectorAll("cd-activity[type='piece-it-together']")
  
  return unless pitActivities.length > 0
  
# THESE ARE DUMB AND SHOULD BE REFACTORED AWAY
  
  droppedItemCorrectly = Curry 2, (game, item)->
    game.pieces.splice(game.pieces.indexOf(item), 1)
    if game.pieces.length is game.nWrongPieces
      gameComplete(game)
    else
      panelUpdate(game, true)
  
  getMatchingGroupPairNearItem = Curry 2, (game, droppedItem)->
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
      handleActivation(game)

    return game
    
    
# RESIZE
  
  handleResize = (game)->
    window.addEventListener("resize", ()-> resize(game))
  
  resize = (game)->
    panelUpdate(game, false)
    
    
# ACTIVATION
  
  handleActivation = (game)->
    attemptActivation(game)
    MainScrollWatcher.onMainChange ()->
      attemptActivation(game)
  
  attemptActivation = (game)->
    if not game.activated and onCurrentMain(game.element)
      game.activated = true
      ComputePanelProperties(game.pieces, game.panel)
      for item in game.pieces
        PieceAnimations.introAnimation(item)
      # Only handle resizes after the intro animation begins, otherwise it might skip the animation
      handleResize(game)
  
  onCurrentMain = (gameElement)->
    main = MainScrollWatcher.getCurrentMain()
    return main?.contains(gameElement)
  
# GAME STATE CHANGE
  
  gameComplete = (game)->
    
    # Hide any remaining "wrong" pieces
    for piece in game.pieces
      piece.element.style.visibility = "hidden"
    
    Panel.victoryDance(game.panel)
    Scoring.addScore(game.element, 1)
  
  panelUpdate = (game, animate = false)->
    ComputePanelProperties(game.pieces, game.panel)
    for item in game.pieces
      PieceAnimations.panelUpdate(item, animate)

  
# INITIALIZATION
  
  # We store all the games in an array, to prevent the GC from collecting them
  games = for pitActivity in pitActivities
    createGame(pitActivity)
