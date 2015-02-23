Take ["BackendLocalStorage", "BackendScorm2004", "Params", "Env"], (LocalStorage, Scorm2004, Params, Env)->
  
  determineBackend = ()->
    switch Params.backend
      # when "auto" then determineBackend() # Doesn't exist yet
      # when "LBS" then LBS # Doesn't exist yet
      when "SCORM2004" then Scorm2004
      # when "SCORM1_2" then Scorm1_2 # Doesn't exist yet
      else LocalStorage
  
  Backend = if Env.dev then LocalStorage else determineBackend()
  Backend.initialize()
  Make("Backend", Backend)
