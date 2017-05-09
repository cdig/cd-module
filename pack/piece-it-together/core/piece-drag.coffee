Take ["PieceAnimations", "PieceProperties", "PieceSettings", "PieceTransformations", "Transitioner","Transformer", "Vector"], (PieceAnimations, PieceProperties, PieceSettings,  PieceTransformations, Transitioner, Transformer, Vector)->
  zIndexTop = 1000 #hard coded values. don't you dare change
  zIndexOnPanel= 100
  moved = (piece,vector)=>
    piece.drag.moved = true
    piece.drag.dragPosition = Vector.add(piece.drag.dragPosition, vector)
    piece.drag.dragPosition = Vector.subtract(piece.drag.dragPosition, piece.drag.lastMousePos)
    PieceTransformations.applyPosition(piece, piece.drag.dragPosition)
    piece.drag.lastMousePos = vector
    return 0
  Make "PieceDrag", (piece)->
    do ()->
      return obj =
        lastMousePos: Vector.create()
        dragPosition: Vector.create()
        moved: false
        mouseDown: (e)=>
          #return unless e.which is 1
          e.preventDefault()
          window.addEventListener("mousemove", piece.drag.mouseMove)
          window.addEventListener("mouseup", piece.drag.mouseUp)
          window.addEventListener("touchmove", piece.drag.touchMove)
          window.addEventListener("touchend", piece.drag.mouseUp)
          window.addEventListener("touchcancel", piece.drag.mouseUp)
          piece.drag.moved = false
          
          PieceSettings.setSettingsForDrag(piece)
          if e.touches?
            e = e.touches[0]
          piece.drag.lastMousePos = Vector.fromEventClient(e)
          piece.drag.dragPosition = Vector.clone(piece.panelPosition)
          piece.scaleAnimation.animateToScale(1)


        touchMove: (e)=>
          e.preventDefault()
          clientVec = Vector.fromEventClient(e.touches[0])
          moved(piece, clientVec)


        mouseMove: (e)=>
          e.preventDefault()
          clientVec = Vector.fromEventClient(e)
          moved(piece, clientVec)




        mouseUp: (e)=>
          e.preventDefault()
          window.removeEventListener("mousemove", piece.drag.mouseMove)
          window.removeEventListener("mouseup", piece.drag.mouseUp)
          window.removeEventListener("touchmove", piece.drag.touchMove)
          window.removeEventListener("touchend", piece.drag.mouseUp)
          window.removeEventListener("touchcancel", piece.drag.mouseUp)
          piece.element.blur()
          piece.drag.handleDrop()

        handleDrop: ()->
          if not piece.drag.moved
            PieceAnimations.returnToPanel(piece)
          else if piece.isWrong
            PieceAnimations.returnToPanel(piece)
          else if piece.drag.isCloseTo(piece)
            piece.drag.handleDropOnOriginalPosition()
          else if (pair = piece.game.getMatchingGroupPairNearItem(piece))?
            piece.drag.handleDropOnMatchingGroupPair(pair)
          else
            PieceAnimations.animateToPanel(piece)
    
    
        handleDropOnOriginalPosition: ()->
          transVector = PieceTransformations.getElementTranslation(piece.original)
          PieceAnimations.transitionToPositionAndScale(piece, transVector, 1, 0.25)

          Transitioner.afterTransition(piece.transitioner,()-> Transformer.remove(piece.transformer))
          PieceSettings.setSettingsForOriginalPosition(piece)
          piece.game.droppedItemCorrectly(piece)


        handleDropOnMatchingGroupPair: (otherItem)->
          #this is pretty messy
          #we need to find the current position of an element and swap them
          pieceOriginalPosition = PieceTransformations.getInitialPosition(piece)
          pieceCurrentPosition = Vector.fromRectPos(piece.element.getBoundingClientRect())
          otherOriginalPosition = PieceTransformations.getInitialPosition(otherItem)
          otherCurrentPosition = Vector.fromRectPos(otherItem.element.getBoundingClientRect())

          dragPositionForOther = Vector.subtract(pieceCurrentPosition, otherOriginalPosition)
          dragPositionForOther = Vector.add(dragPositionForOther, PieceTransformations.getElementTranslation(otherItem.original))
          panelPositionForOriginal = Vector.subtract(otherCurrentPosition, pieceOriginalPosition)
          panelPositionForOriginal = Vector.add(panelPositionForOriginal, PieceTransformations.getElementTranslation(piece.original))
          otherScale = 1.0
          panelScale = otherItem.scale

          piece.panelPosition = panelPositionForOriginal
          piece.drag.dragPosition = piece.panelPositionForOriginal
          PieceTransformations.applyPosition(piece, panelPositionForOriginal)
          PieceTransformations.applyScale(piece, panelScale)
          PieceTransformations.applyPosition(otherItem, dragPositionForOther)
          PieceTransformations.applyScale(otherItem, otherScale)
          otherItem.drag.moved = true
          otherItem.drag.dragPosition = dragPositionForOther
          otherItem.scale = otherScale
          otherItem.drag.handleDrop()


        
        isCloseTo: (otherItem)->
          ourPosition = Vector.fromRectPos(piece.element.getBoundingClientRect())
          otherPosition = PieceTransformations.getInitialPosition(otherItem)
          d = Vector.subtract(ourPosition, otherPosition)
          
          distance = d.x*d.x + d.y*d.y
          w = PieceProperties.width(otherItem)
          h = PieceProperties.height(otherItem)

          threshold = (w*w + h*h) / 12 #higher the threshold value, easier it is to hit
          return distance < threshold
