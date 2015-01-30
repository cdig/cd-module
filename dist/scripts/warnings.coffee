Take ["Env", "load"], (Env)->
  
  return unless Env.dev
  
# FUNCTIONS
  
  check = (selector, message)->
    violations = document.querySelectorAll(selector)
    if violations.length > 0
      console.log "Warning: #{message}", violations
  
  
# INITIALIZATION
  
  check("cd-page:not([id])", "All cd-pages must have a unique id")
  check("cd-row > img", "Don't put images directly in cd-row — wrap them in a div")
