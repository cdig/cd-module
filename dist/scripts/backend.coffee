Take ["BackendLocalStorage", "BackendScorm2004", "Params"], (LocalStorage, Scorm2004, Params)->
  
  Backend = switch Params.backend
    # when "auto" then determineBackend() # Doesn't exist yet
    # when "LBS" then LBS # Doesn't exist yet
    when "SCORM2004" then Scorm2004
    # when "SCORM1_2" then Scorm1_2 # Doesn't exist yet
    else LocalStorage
  
  Backend.initialize()
  Make("Backend", Backend)
