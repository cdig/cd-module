Take ["Config", "DOMContentLoaded"], (Config)->

  showAllButton = document.querySelector("[focus-mode-button]") # This element is defined in top.kit
  elements = [] # Store a reference to elements so we can save and restore by index via Config
  focussedElm = null


  # When holding the alt key, show the yellow focus-mode selector overlay
  updateOverlay = (e)->
    DOOM document.body, "focus-mode-overlay": e.altKey


  turnOff = ()->
    if focussedElm?
      # Store the current window-relative position of the elm
      top = focussedElm.offsetTop - document.scrollingElement.scrollTop

      # Clear all focus mode state
      focussedElm.removeAttribute "focus-mode"
      focussedElm.parentElement.removeAttribute "focus-mode"
      document.body.removeAttribute "focus-mode"
      Config "focus", null

      # Restore the window-relative position of the elm
      document.scrollingElement.scrollTop = focussedElm.offsetTop - top

      focussedElm = null


  toggle = (elm)->
    # If we toggle an already-focussed element, just turn off focus mode
    return turnOff() if elm is focussedElm

    # If we're already focussed on some other element, clear it
    if focussedElm?
      focussedElm.removeAttribute "focus-mode"
      focussedElm.parentElement.removeAttribute "focus-mode"

    # Focus on the new element
    focussedElm = elm
    elm.setAttribute "focus-mode", true
    elm.parentElement.setAttribute "focus-mode", true
    document.body.setAttribute "focus-mode", true
    Config "focus", elements.indexOf elm

    # Set the scroll position so that the Show All button is just tucked under the header
    document.scrollingElement.scrollTop = showAllButton.offsetHeight


  click = (e)->
    updateOverlay e
    toggle e.currentTarget if e.altKey # Only activate on option-click


  # INIT

  for elm in document.querySelectorAll "cd-page > *"
    elm.addEventListener "click", click
    elements.push elm

  showAllButton.addEventListener "click", turnOff
  window.addEventListener "keydown", updateOverlay
  window.addEventListener "keyup", updateOverlay

  if (focussedIndex = Config "focus")?
    toggle elements[focussedIndex]
