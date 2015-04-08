Take "load", ()->
  Make "UnitsConverter", UnitsConverter =
    getEmPixels: ()->
      return parseFloat(window.getComputedStyle(document.documentElement).fontSize)
