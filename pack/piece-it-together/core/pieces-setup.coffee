Take ["Piece","PieceDrag","PureArray", "ScaleAnimation", "Vector", "load"], (Piece, PieceDrag,PureArray, ScaleAnimation, Vector)->
  SELECTOR = "[piece]"
  Make "PiecesSetup", PiecesSetup =
    makePieces: (gameElement, gameInstance)->
      itemElements = gameElement.querySelectorAll(SELECTOR)
      console.assert(itemElements.length > 0, "Nothing with selector #{SELECTOR} was found in:", gameElement)
      pieces = for original in itemElements
        cloned = original.cloneNode(true)
        original.style.visibility = "hidden" #make the original invisible
        gameElement.querySelector('cd-map').appendChild(cloned)
        piece = Piece.create(cloned, original, gameInstance)
        piece.drag = PieceDrag(piece)
        piece.scaleAnimation = ScaleAnimation(piece)
        piece
      pieces = PureArray.shuffle(pieces) #put the pieces in a randomised order
      return pieces
