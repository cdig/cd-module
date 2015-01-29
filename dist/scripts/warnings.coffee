Take ["Env", "load"], (Env)->
  
  return unless Env.dev
  
# FUNCTIONS
  
  check = (selector, message)->
    violations = document.querySelectorAll(selector)
    if violations.length > 0
      console.log false, "Warning: #{message}", violations
  
  
# INITIALIZATION
  
  check("cd-row > img", "Don't put images directly in cd-row — wrap them in a div")
  
  
  
