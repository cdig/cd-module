do ()->
  Take "load", ()->
    check("cd-row > img", "Don't put images directly in cd-row — wrap them in a div")
  
  check = (selector, message)->
    violations = document.querySelectorAll(selector)
    if violations.length > 0
      console.log "Warning: #{message}", violations
