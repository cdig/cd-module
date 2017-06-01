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
