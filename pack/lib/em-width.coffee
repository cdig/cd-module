Take "DOMContentLoaded", ()->
  for elm in document.querySelectorAll "[em-width]:not(side-scroller)"
    w = elm.getAttribute "em-width"
    elm.style.width = w + "rem"
    elm.style.maxWidth = "100%"
