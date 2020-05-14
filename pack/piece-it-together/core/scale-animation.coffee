Take ["PieceTransformations", "load"], (PieceTransformations)->
  scaleAnimationDuration = 200

  easeScale = (a, b, c)->
    return b + (c * a/scaleAnimationDuration)

  Make "ScaleAnimation", (piece)->
    piece: piece
    running: false
    target: 0
    startTime: null

    animateToScale: (scale)->
      piece.scaleAnimation.stopScaleAnimation() if piece.scaleAnimation.running
      piece.scaleAnimation.running = true
      piece.scaleAnimation.target = scale
      requestAnimationFrame(piece.scaleAnimation.runScaleAnimation)

    runScaleAnimation: (currentTime)->
      return unless piece.scaleAnimation.running

      piece.scaleAnimation.startTime ?= currentTime
      elapsedTime = currentTime - piece.scaleAnimation.startTime

      if (elapsedTime < scaleAnimationDuration)
        # This is gross because the ease function is gross — arguments 2 & 3 are unintuitive.
        newScale = easeScale(elapsedTime, piece.scale, piece.scaleAnimation.target - piece.scale)
        PieceTransformations.applyScale(piece, newScale)
        requestAnimationFrame(piece.scaleAnimation.runScaleAnimation)
      else
        piece.scaleAnimation.finishScaleAnimation()


    finishScaleAnimation: ()->
      PieceTransformations.applyScale(piece)
      piece.scaleAnimation.stopScaleAnimation(piece)


    stopScaleAnimation: ()->
      piece.scaleAnimation.running = false
      piece.scaleAnimation.startTime = null
