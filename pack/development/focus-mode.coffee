Take ["Config", "DOMContentLoaded"], (Config)->
  return unless Config "dev"
  
  elements = [] # Store a reference to elements so we can save and restore by index via Config

  getId = (elm)->
    for e, id in elements when e is elm
      return id
  
  toggle = (elm)->
    # Store the position of the elm in the window
    top = elm.offsetTop - document.body.scrollTop
    
    # Turn on focus
    if not elm.hasAttribute "focus-mode"
      elm.setAttribute "focus-mode", true
      elm.parentElement.setAttribute "focus-mode", true
      document.body.setAttribute "focus-mode", true
      Config "focus-mode", getId(elm)
    
    # Turn off focus mode
    else
      elm.removeAttribute "focus-mode"
      elm.parentElement.removeAttribute "focus-mode"
      document.body.removeAttribute "focus-mode"
      Config "focus-mode", null
    
    # Restore the position of the elm in the window
    document.body.scrollTop = elm.offsetTop - top
  
  # Closure over the reference to elm
  setup = (elm)->
    elm.addEventListener "click", (e)->
      toggle elm if e.altKey # Only activate on option-click
  
  # Setup on all children of cd-page elements
  for elm in document.querySelectorAll "cd-page > *"
    elements.push elm
    setup elm
  
  # Immediately activate focus-mode if Config tells us to
  savedFocus = Config "focus-mode"
  toggle elements[savedFocus] if savedFocus?
