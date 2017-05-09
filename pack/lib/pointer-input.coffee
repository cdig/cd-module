do ()->
  clicks = []
  downs = []
  moves = []
  ups = []
  overs = []
  outs = []
  
  Make "PointerInput", PointerInput =
    addClick: (element, callback)->
      element.addEventListener "click", callback
      clicks.push {element: element, callback: callback}
    
    removeClick: (element, callback)->
      for click, index in clicks
        if element is click.element and callback is click.callback
          clicks.splice(index, 1)
          element.removeEventListener "click", click.callback
          return
    
    addDown: (element, callback)->
      downFunc = (e)->
        e.preventDefault()
        if e.touches?
          callback(e.touches[0])
        else
          callback(e)
      element.addEventListener "mousedown", downFunc
      element.addEventListener "touchstart", downFunc
      downs.push {element: element, callback: callback, downFunc: downFunc}
    
    removeDown: (element, callback)->
      for down, index in downs
        if element is down.element and callback is down.callback
          downs.splice(index, 1)
          element.removeEventListener "mousedown", down.downFunc
          element.removeEventListener "touchstart", down.downFunc
          return
    
    addMove: (element, callback)->
      moveFunc = (e)->
        e.preventDefault()
        if e.touches?
          callback(e.touches[0])
        else
          callback(e)
      element.addEventListener "mousemove", moveFunc
      element.addEventListener "touchmove", moveFunc
      moves.push {element: element, callback: callback, moveFunc: moveFunc}
    
    removeMove: (element, callback)->
      for move, index in moves
        if element is move.element and callback is move.callback
          moves.splice(index, 1)
          element.removeEventListener "mousemove", move.moveFunc
          element.removeEventListener "touchmove", move.moveFunc
          return
    
    addUp: (element, callback)->
      element.addEventListener "mouseup", callback
      element.addEventListener "touchend", callback
      element.addEventListener "touchcancel", callback
      window.addEventListener "mouseup", callback
      window.addEventListener "onmouseleave", callback
      ups.push {element: element, callback: callback}
    
    removeUp: (element, callback)->
      for up, index in ups
        if element is up.element and callback is up.callback
          ups.splice(index, 1)
          element.removeEventListener "mouseup", up.callback
          element.removeEventListener "touchend", up.callback
          element.removeEventListener "touchcancel", up.callback
          window.removeEventListener "mouseup", up.callback
          window.removeEventListener "onmouseleave", up.callback
          return


    addOver: (element, callback)->
      element.addEventListener "mouseover", callback
      overs.push {element: element, callback: callback}

    
    addOut: (element, callback)->
      element.addEventListener "mouseout", callback
      outs.push {element: element, callback: callback}
