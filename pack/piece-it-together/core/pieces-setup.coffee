Take ["Piece", "PieceDrag", "ScaleAnimation"], (Piece, PieceDrag, ScaleAnimation)->

  Make "PiecesSetup", PiecesSetup = (game)->
    container = game.element.querySelector("cd-map") or game.element.firstChild

    for elm in game.element.querySelectorAll "[piece]"
      cloned = elm.cloneNode true
      elm.style.visibility = "hidden"
      container.appendChild cloned
      piece = Piece.create cloned, elm, game
      piece.drag = PieceDrag piece
      piece.scaleAnimation = ScaleAnimation piece
      piece
