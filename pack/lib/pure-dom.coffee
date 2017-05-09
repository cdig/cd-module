# PureDom
# Pure functional helpers that make it easier to work with the DOM.

Make "PureDom", PureDom =
  
  isElement: (elm)->
    return elm instanceof HTMLElement
  
  nodeListToArray: (nodeList)->
    throw "PureDom.nodeListToArray(nodeList) called with null value" unless nodeList?
    return Array.prototype.slice.call(nodeList)
  
  # Here's the equivalent function in the spec: https://developer.mozilla.org/en-US/docs/Web/API/Element.closest
  # At the time this function was written, the spec version was not known.
  querySelectorParent: (element, selector)->
    throw "PureDom.querySelectorParent(null, \"#{selector}\") called with null element" unless element?
    # throw "PureDom.querySelectorParent(#{element}, \"#{selector}\") called with non-element" unless element.matches?
    throw "PureDom.querySelectorParent(#{element}, null) called with null selector" unless selector?
    
    # Polyfill matches right here!
    if element.matches?(selector) or element.matchesSelector?(selector) or element.msMatchesSelector?(selector) or element.oMatchesSelector?(selector) or element.mozMatchesSelector?(selector) or element.webkitMatchesSelector?(selector)
      return element
      
    else if element.parentNode?
      # ^ Previously used parentElement, but this seemingly didn't work in SVGs
      # ^ Also, previously excluded the HTML element (for SVG, maybe?) but this had unintended side effects
      return PureDom.querySelectorParent(element.parentNode, selector)
      
    else
      return null
  
  querySelectorAll: (element, selector)->
    throw "PureDom.querySelectorAll(element, selector) called with null element" unless element?
    throw "PureDom.querySelectorAll(element, selector) called with null selector" unless selector?

    return PureDom.nodeListToArray(element.querySelectorAll(selector))

  querySelectorAllChildren: (element, selector)->
    throw "PureDom.querySelectorAllChildren(element, selector) called with null element" unless element?
    throw "PureDom.querySelectorAllChildren(element, selector) called with null selector" unless selector?
    list = element.querySelectorAll(selector)
    return (item for item in list when item.parentNode is element)
