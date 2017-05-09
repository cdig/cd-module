Make "PureMath", PureMath =
  
  clip: (input, min = 0, max = 1)->
    return min if input < min
    return max if input > max
    return input
  
  distance: (x0, y0, x1 = 0, y1 = 0)->
    console.log "PureMath.distance() is deprecated — please use Vector.distance()"
    dx = x0 - x1
    dy = y0 - y1
    return Math.sqrt(dX * dX + dY * dY)
    
  map: ()->
    throw new Error("PureMath.map() is obsolete — please use Ease.linear()")
  
  random: (min, max)->
    return min + (max - min) * Math.random()
