Take ["Panel","Piece","Transitioner", "Vector"], (Panel, Piece, Transitioner, Vector)->
  zIndexTop = 1000
  zIndexOnPanel= 100
  Make "PieceStyle", PieceStyle =
    enableTransformTransitions: (piece, enable = true, duration = .5)->

      call = if enable then "add" else "remove"

      Transitioner[call](piece.transitioner, "-webkit-transform", duration)
      Transitioner[call](piece.transitioner, "-ms-transform", duration)
      Transitioner[call](piece.transitioner, "transform", duration)

    enablePointerEvents: (piece, enable = true)->
      piece.element.style['pointer-events'] = if enable then '' else 'none'

    setZIndex: (piece, zIndex)->
      piece.element.style['z-index'] = zIndex
