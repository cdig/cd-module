Take ["Panel","Piece", "PieceSettings","PieceStyle", "PieceTransformations", "Transitioner", "Vector"], (Panel, Piece, PieceSettings, PieceStyle, PieceTransformations, Transitioner, Vector)->

  Make "PieceAnimations", PieceAnimations  =
    panelUpdate: (piece, animate=true)->
      if animate
        PieceAnimations.introAnimation(piece)
      else
        PieceAnimations.animateToPanel(piece, 0.01)
        

    introAnimation: (piece)->
      PieceAnimations.animateToPanel(piece)

    animateToPanel: (piece, duration = 0.5)->
      PieceSettings.setSettingsForAnimation(piece)
      PieceAnimations.transitionToPositionAndScale(piece, piece.panelPosition, piece.panelScale, duration)
      Transitioner.afterTransition(piece.transitioner,()-> PieceSettings.setSettingsForPanel(piece))

    transitionToPositionAndScale: (piece, position, scale, duration = 1)->
      PieceStyle.enableTransformTransitions(piece, true, duration)
      Transitioner.afterTransition piece, ()->
        PieceStyle.enableTransformTransitions(piece, false)
      piece.scaleAnimation.stopScaleAnimation()
      
      PieceTransformations.applyScale(piece, scale)
      PieceTransformations.applyPosition(piece, position)

    snapToPanel: (piece)->
      PieceSettings.setSettingsForPanel(piece)
      PieceTransformations.applyScale(piece, piece.panelScale)
      PieceTransformations.applyPosition(piece, panelPosition)


    returnToPanel: (piece)->
      PieceSettings.setSettingsForPanel(piece)
      piece.scaleAnimation.animateToScale(piece.panelScale)
      PieceTransformations.applyPosition(piece, piece.panelPosition)
