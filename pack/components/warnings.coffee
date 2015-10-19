Take ["Env", "cdHUD", "ModalPopup", "load"], (Env, cdHUD, ModalPopup)->
  
  return unless Env.dev or Env.debug
  
  warningIndicator = null
  
  
# FUNCTIONS
  
  doChecks = ()->
    check("cd-page:not([id])", "All cd-pages must have a unique id")
    check("cd-row > img", "Don't put images directly in cd-row — wrap them in a div")
    check("main", "Use cd-main instead of main")
    check("cd-callouts", "cd-callouts is deprecated — tell Ivan you saw this")
    check(".callouts", ".callouts is deprecated — tell Ivan you saw this")
    # This rule is complicated because of weirdness from SWFObject:
    # It seems to generate stray <object> elements without a [data] attribute, and then remove them later.
    # If we have an object that has a [data] attribute and no [cd-swf] attribute, then that's worthy of a Warning.
    check("object[data]:not([cd-swf]):not([type='image/svg+xml'])", "Please use cd-swf to embed flash")
  
  check = (selector, message)->
    violations = document.querySelectorAll(selector)
    if violations.length > 0
      console.log "Warning: #{message}", violations
      showWarningIndicator()
  
  showWarningIndicator = ()->
    return if warningIndicator?
    cdHUD.addButton "Warnings", ()->
      ModalPopup.open "Oh No", "1. Open the console to see the warnings.<br>2. Fix the warnings.<br>3. Profit."
  
  
# INITIALIZATION
  
  doChecks()
