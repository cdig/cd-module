Take "DOMContentLoaded", ()->
  for elm in document.querySelectorAll "[em-width]"
    w = elm.getAttribute "em-width"
    elm.style.width = w + "em"
    elm.style.maxWidth = "100%"
