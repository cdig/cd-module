Take "DOMContentLoaded", ()->
  for elm in document.querySelectorAll "[width]"
    w = elm.getAttribute "width"
    if w.indexOf("em") is w.length - 2
      elm.style.width = w
      elm.style.maxWidth = "100%"
