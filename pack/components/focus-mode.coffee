Take "DOMContentLoaded", ()->
  
  # Closure over the reference to elm
  setup = (elm)->
    
    elm.addEventListener "click", (e)->
      # Only activate on option-click
      return unless e.altKey
      
      # Store the position of the elm in the window
      top = elm.offsetTop - document.body.scrollTop
      
      # Turn on focus
      if not elm.hasAttribute "focus-mode"
        elm.setAttribute "focus-mode", true
        elm.parentElement.setAttribute "focus-mode", true
        document.body.setAttribute "focus-mode", true

      # Turn off focus mode
      else
        elm.removeAttribute "focus-mode"
        elm.parentElement.removeAttribute "focus-mode"
        document.body.removeAttribute "focus-mode"
            
      # Restore the position of the elm in the window
      document.body.scrollTop = elm.offsetTop - top
      
  # Setup on all children of cd-page elements
  setup elm for elm in document.querySelectorAll "cd-page > *"
