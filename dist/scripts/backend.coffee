Take ["BackendLocalStorage", "BackendScorm2004", "Env"], (LocalStorage, Scorm2004, Env)->
  
  # If we're standalone, debug, or in development, we should use LocalStorage
  local = !Env.parent? or Env.debug or Env.dev
  
  Backend = if local then LocalStorage else Scorm2004
  Backend.initialize()
  Make("Backend", Backend)
