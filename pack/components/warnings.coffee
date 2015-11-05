Take ["Env", "cdHUD", "ModalPopup", "load"], (Env, cdHUD, ModalPopup)->
  
  return unless Env.dev or Env.debug
  hasWarnings = false
  
  
  showWarningIndicator = ()->
    if not hasWarnings
      hasWarnings = true
      cdHUD.addButton
        text: "Warnings"
        attr: "cd-hud-warnings"
        order: 4
        click: ()-> ModalPopup.open "Oh No", "1. Open the console to see the warnings.<br>2. Fix the warnings.<br>3. Profit."
  
  
  check = (selector, message)->
    violations = document.querySelectorAll selector
    if violations.length > 0
      console.log "Warning: #{message}", violations
      showWarningIndicator()
  
  
  check "cd-page:not([id])", "All cd-pages must have a unique id"
  check "cd-row > img", "Don't put images directly in cd-row — wrap them in a div"
  check "main", "Use cd-main instead of main"
