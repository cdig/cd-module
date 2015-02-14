Take ["Env", "cdHUD", "load"], (Env, cdHUD)->
  
  return unless Env.dev or Env.debug
  
  warningIndicator = null
  
  
# FUNCTIONS
  
  doChecks = ()->
    check("cd-page:not([id])", "All cd-pages must have a unique id")
    check("cd-row > img", "Don't put images directly in cd-row — wrap them in a div")
    
    # This rule is complicated because of weirdness from SWFObject:
    # It seems to generate stray <object> elements without a [data] attribute, and then remove them later.
    # If we have an object that has a [data] attribute and no [cd-swf] attribute, then that's worthy of a Warning.
    check("object[data]:not([cd-swf])", "Please use cd-swf to embed flash")
  
  check = (selector, message)->
    violations = document.querySelectorAll(selector)
    if violations.length > 0
      console.log "Warning: #{message}", violations
      showWarningIndicator() unless warningIndicator?

  showWarningIndicator = ()->
    warningIndicator = document.createElement("warning-indicator")
    warningIndicator.textContent = "Warnings"
    cdHUD.addElement(warningIndicator)
  
  
# INITIALIZATION
  
  doChecks()
