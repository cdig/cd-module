Take ["Config", "DOMContentLoaded"], (Config)->
  
  return unless Config "dev"
  warningIndicator = document.querySelector "warning-indicator"
  
  check = (selector, message)->
    violations = document.querySelectorAll selector
    if violations.length > 0
      console.log "Warning: #{message}", violations
      warningIndicator.style.display = "block"
  
  check "cd-page:not([id])", "All cd-pages must have a unique id"
  check "cd-row > img", "Don't put images directly in cd-row — wrap them in a div"
  check "main", "Use cd-main instead of main"
  check "call-out:not([top]):not([left]):not([right]):not([bottom])", "You must specify either top, left, right, or bottom on your call-out."
  check "center-block cd-row", "Don't put cd-row inside a center-block"
  check ":not(cd-page) > cd-main", "It looks like you're missing a closing tag"
  check ".framed > *", "Please use the `framed` class directly on your images, not on container elements."
  check "cd-text-bubble cd-row", "Don't use cd-row inside a cd-text-bubble. If you want to put an image beside your bubble text, float it using the float-left or float-right class."
  check ".width-auto", "The width-auto class has been removed. Please set precise widths, or don't set a width at all."
  check "p[pin]", "Don't use <p> tags as your cd-map pinned items. Use <div>."
  check "cd-row > cd-map", "Don't put cd-map as a direct child of cd-row. Wrap it with a div."
  check "cd-row > [row] > [type=\"Et Tu, Q?\"]", "When you put a QnA inside a cd-row, it's best to not customize the row item containing the QnA. The defaults are good enough, hey?"
  
  names = {}
  for activity in document.querySelectorAll "cd-activity"
    name = activity.getAttribute "name"
    if names[name]?
      if names[name] isnt "warned"
        console.log "Error: You have more than one cd-activity named \"#{name}\". Each activity must have a unique name."
        warningIndicator.style.display = "block"
        names[name] = "warned"
    else
      names[name] = true
