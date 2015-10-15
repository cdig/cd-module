Take "DOMContentLoaded", ()->
  
  addClick = (elm)->
    elm.addEventListener "click", (e)->
      
      # Only activate on option-click
      return unless e.altKey
      
      # Store the position of the elm in the window
      top = elm.offsetTop - document.body.scrollTop
      
      # Turn on focus
      if not elm.hasAttribute "focus"
        elm.setAttribute "focus", true
        elm.parentElement.setAttribute "focus", true
        document.body.setAttribute "focus", true

      # Turn off focus mode
      else
        elm.removeAttribute "focus"
        elm.parentElement.removeAttribute "focus"
        document.body.removeAttribute "focus"
            
      # Restore the position of the elm in the window
      document.body.scrollTop = elm.offsetTop - top
      
  # Setup on all children of cd-page elements
  addClick elm for elm in document.querySelectorAll "cd-page > *"
