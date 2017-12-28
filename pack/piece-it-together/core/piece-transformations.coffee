Take ["Panel", "PieceSettings","Transformer", "Vector"], (Panel, PieceSettings,Transformer, Vector)->
  extractTransform = (element)->
    style = window.getComputedStyle(element)
    webkit = style.getPropertyValue("-webkit-transform")
    standard = style.getPropertyValue("transform")

    return standard or webkit

  extractTranslate = (transformString)->
    matches = transformString.match(/matrix\(([^-]*), 0, 0, ([^-]*), (.+), (.+)\)/)

    return Vector.create() if not matches?

    if matches.length >= 3
      x = parseInt(matches[matches.length - 2])
      y = parseInt(matches[matches.length - 1])
      return Vector.create(x, y)
    else
      return Vector.create()

  Make "PieceTransformations", PieceTransformations =
    # TRANSFORMATIONS ##################################################################################
    animateToPanel: ()->
      PieceSettings.setSettingsForAnimation(piece)
      transitionToPositionAndScale(panelPosition, panelScale, .5)
      transitioner.afterTransition(setSettingsForPanel)

    localToGlobal: (piece, position)->
      transformedPosition = Vector.create()
      recPos = Vector.fromRectPos(piece.element.getBoundingClientRect())
      transformedPosition = Vector.subtract(transformedPosition, recPos)
      transformedPosition = Vector.add(transformedPosition, position)
      return transformedPosition

    getDragPanelPosition: (piece, position, panelPosition)->
      transformedPosition = Vector.create()
      recPos = Vector.fromRectPos(piece.element.getBoundingClientRect())
      transformedPosition = Vector.subtract(transformedPosition, recPos)
      transformedPosition = Vector.add(transformedPosition, position)
      transformedPosition = Vector.add(transformedPosition, panelPosition)
      return transformedPosition

    getComparativePosition: (piece, position)->
      translatePosition = extractTranslate(extractTransform(piece.element))
      piecePosition = Vector.fromRectPos(piece.element.getBoundingClientRect())
      transformedPosition = Vector.create()
      transformedPosition = Vector.add(transformedPosition, position)
      transformedPosition = Vector.subtract(transformedPosition, translatePosition)
      transformedPosition = Vector.subtract(transformedPosition, piecePosition)
      return transformedPosition

    getInitialPosition: (piece)->
      transformedPosition = Vector.fromRectPos(piece.original.getBoundingClientRect())
      return transformedPosition


    getElementTranslation: (element)->
      transString = extractTransform(element)
      return extractTranslate(transString)

    getPanelPosition: (piece, position)->
      transformedPosition = Vector.create()
      prevPosition = extractTranslate(extractTransform(piece.element))
      transformedPosition = Vector.add(transformedPosition, prevPosition)
      recPos = Vector.fromRectPos(piece.element.getBoundingClientRect())
      transformedPosition = Vector.subtract(transformedPosition, recPos)
      transformedPosition = Vector.add(transformedPosition, position)
      return transformedPosition


    globalToLocal: (piece, position)->
      transformedPosition = Vector.create()
      transformedPosition = Vector.add(transformedPosition, position)
      transformedPosition = Vector.add(transformedPosition, Vector.fromRectPos(piece.element.getBoundingClientRect()))
      return transformedPosition


    applyScale: (piece, scale)->
      piece.scale = scale if scale?
      Transformer.scale(piece.transformer, piece.scale)

    applyPosition: (piece, position)->
      piece.position = position if position?
      Transformer.translate(piece.transformer, position)
