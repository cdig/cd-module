# Loading
# After the DOM content has loaded, we'll add an attr to the <html> element.
# This way, CSS can hook into that event and change their display (eg: hiding/unhiding stuff) as necessary.

Take "DOMContentLoaded", ()->
  document.documentElement.setAttribute "dom-content-loaded", ""
