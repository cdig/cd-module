Take ["Env", "cdHUD", "ModalPopup", "load"], (Env, cdHUD, ModalPopup)->
  
  return unless Env.dev or Env.debug
  
  warningIndicator = null
  
  
# FUNCTIONS
  
  doChecks = ()->
    check("cd-page:not([id])", "All cd-pages must have a unique id")
    check("cd-row > img", "Don't put images directly in cd-row — wrap them in a div")
    check("main", "Use cd-main instead of main")
    # This rule is complicated because of weirdness from SWFObject:
    # It seems to generate stray <object> elements without a [data] attribute, and then remove them later.
    # If we have an object that has a [data] attribute and no [cd-swf] attribute, then that's worthy of a Warning.
    check("object[data]:not([cd-swf]):not([type='image/svg+xml'])", "Please use cd-swf to embed flash")
  
  check = (selector, message)->
    violations = document.querySelectorAll(selector)
    if violations.length > 0
      console.log "Warning: #{message}", violations
      showWarningIndicator() unless warningIndicator?

  showWarningIndicator = ()->
    warningIndicator = document.createElement("warning-indicator")
    warningIndicator.textContent = "Warnings"
    warningIndicator.addEventListener "click", ()->
      ModalPopup.open("This Module Has Warnings", "1. Open the console to see the warnings. 2. Fix the warnings. 3. Profit.");
    cdHUD.addElement(warningIndicator)
  
  
# INITIALIZATION
  
  doChecks()
