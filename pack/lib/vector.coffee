Take "Curry", (Curry)->
  Make "Vector", Vector =
    
    # Constructors
    
    create: (x = 0, y = 0)->
      return { x:x, y:y }

    clone: (vector)->
      return {x: vector.x, y:vector.y}
    
    fromEventClient: (e)->
      return Vector.create(e.clientX, e.clientY)
    
    fromPageOffset: ()->
      return Vector.create(window.pageXOffset, window.pageYOffset)
    
    fromRectPos: (rect)->
      Vector.create(rect.left, rect.top)
    
    fromElementOffset: (element)->
      Vector.create(element.offsetLeft, element.offsetTop)

    fromRectSize: (rect)->
      Vector.create(rect.width, rect.height)
    
    
    # Coordinate Systems
    
    screenToWindow: (v)->
      return Vector.add(v, Vector.fromPageOffset())
    
    windowToScreen: (v)->
      return Vector.subtract(v, Vector.fromPageOffset())
    
    
    # Higher-Order Functions
    
    map: Curry 2, (fn, v)->
      return Vector.create(fn(v.x), fn(v.y))
    
    
    # Math: Vector to Vector
    
    add: (a, b)->
      b = Vector.create(b, b) unless isNaN(b)
      return Vector.create(a.x + b.x, a.y + b.y)
      
    subtract: (a, b)->
      b = Vector.create(b, b) unless isNaN(b)
      return Vector.create(a.x - b.x, a.y - b.y)

    multiply: (a, b)->
      b = Vector.create(b, b) unless isNaN(b)
      return Vector.create(a.x * b.x, a.y * b.y)
    
    divide: (a, b)->
      b = Vector.create(b, b) unless isNaN(b)
      return Vector.create(a.x / b.x, a.y / b.y)
    
    
    # Math: Mixed
    
    # length [optional] lets you normalize to another vector, or to a scalar, instead of unit length
    normalize: (vec, length)->
      length ?= Vector.length(vec)
      return Vector.divide(vec, length)
    
    length: (v)->
      return Math.sqrt(v.x * v.x + v.y * v.y)
