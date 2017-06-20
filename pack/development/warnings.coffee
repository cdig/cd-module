Take ["Config", "DOMContentLoaded"], (Config)->
  
  return unless Config "dev"
  warningIndicator = document.querySelector "warning-indicator"
  
  # Existence
  
  assertNonexistence = (selector, message)->
    violations = document.querySelectorAll selector
    if violations.length > 0
      console.log "Warning: #{message}", violations
      warningIndicator.style.display = "block"
  
  assertNonexistence "cd-page:not([id])", "All cd-pages must have a unique id"
  assertNonexistence "cd-row > img", "Don't put images directly in cd-row — wrap them in a div"
  assertNonexistence "main", "Use cd-main instead of main"
  assertNonexistence "call-out:not([top]):not([left]):not([right]):not([bottom])", "You must specify either top, left, right, or bottom on your call-out."
  assertNonexistence "center-block cd-row", "Don't put cd-row inside a center-block"
  assertNonexistence ":not(cd-page) > cd-main", "It looks like you're missing a closing tag"
  assertNonexistence ".framed > *", "Please use the `framed` class directly on your images, not on container elements."
  assertNonexistence "cd-text-bubble cd-row", "Don't use cd-row inside a cd-text-bubble. If you want to put an image beside your bubble text, float it using the float-left or float-right class."
  assertNonexistence ".width-auto", "The width-auto class has been removed. Please set precise widths, or don't set a width at all."
  assertNonexistence "p[pin]", "Don't use <p> tags as your cd-map pinned items. Use <div>."
  assertNonexistence "cd-row > cd-map", "Don't put cd-map as a direct child of cd-row. Wrap it with a div."
  assertNonexistence "[onclick]", "Don't use inline JavaScript. Use external CoffeeScript for lightweight interactivity, or SVGA for richer interactivity."
  
  # Uniqueness
  
  assertAttrUnique = (selector, attr, msgFn)->
    vals = {}
    for elm in document.querySelectorAll selector
      val = elm.getAttribute attr
      if vals[val]?
        if vals[val] isnt "warned"
          console.log msgFn val
          warningIndicator.style.display = "block"
          vals[val] = "warned"
      else
        vals[val] = true
  
  assertAttrUnique "cd-activity", "name", (val)-> "Error: You have more than one cd-activity named \"#{val}\". Each activity must have a unique name."
  assertAttrUnique "[id]", "id", (val)-> "Error: You have more than one element with the id \"#{val}\". Each id must be unique."
