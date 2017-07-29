Take "DOMContentLoaded", ()->
  for elm in document.querySelectorAll "side-scroller"
    w = elm.getAttribute "em-width"
    for child in elm.children
      child.style.minWidth = w + "rem"
