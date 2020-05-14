Take ["ComputePanelProperties", "OnScreen", "Panel", "PiecesSetup", "PieceAnimations", "Shuffle", "load"], (ComputePanelProperties, OnScreen, Panel, PiecesSetup, PieceAnimations, Shuffle)->

  activities = document.querySelectorAll("cd-activity[type='piece-it-together']")

  return unless activities.length > 0

  droppedItemCorrectly = (game)-> (item)->
    game.pieces.splice(game.pieces.indexOf(item), 1)
    if game.pieces.length is game.nWrongPieces
      gameComplete(game)
    else
      panelUpdate(game, true)

  getMatchingGroupPairNearItem = (game)-> (droppedItem)->
    for item in game.pieces
      if item isnt droppedItem
        if item.matchGroup isnt ""
          if item.matchGroup is droppedItem.matchGroup
            if droppedItem.drag.isCloseTo item
              return item
    return null

# RESIZE

  handleResize = (game)->
    window.addEventListener "resize", ()-> resize game

  resize = (game)->
    panelUpdate game, false


# ACTIVATION

  attemptActivation = (game)-> (elm, visible)->
    if visible and not game.activated
      game.activated = true
      ComputePanelProperties(game.pieces, game.panel)
      for item in game.pieces
        PieceAnimations.introAnimation(item)
      # Only handle resizes after the intro animation begins, otherwise it might skip the animation
      handleResize(game)
      game.element.setAttribute "ready", ""


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


  # INIT

  setup = (elm)->
    game =
      element: elm
      activated: false
    game.pieces = Shuffle PiecesSetup game
    game.nWrongPieces = game.pieces.filter((p)-> p.isWrong).length
    game.panel = Panel.makePanel game
    game.getMatchingGroupPairNearItem = getMatchingGroupPairNearItem game
    game.droppedItemCorrectly = droppedItemCorrectly game

    # Bugfix: Without the setTimeout, the activity might not initialize properly
    # if it is already on screen right as the code finishes loading.
    setTimeout ()->
      OnScreen game.element, attemptActivation game

  for activity in activities
    setup activity
