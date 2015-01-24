Take ["BackendLocalStorage", "BackendScorm2004", "Params"], (LocalStorage, Scorm2004, Params)->
  
  # If we haven't been loaded by the Launcher, then we're a standalone module
  standalone = !Params.module?
  
  # Figure out if we're running in debug mode
  debug = Params.debug
  
  # Figure out if we're being loaded in a dev tool
  parts = location.hostname.split(".")
  tld = parts[parts.length-1]
  ck = tld is "local" or parts.length is 1
  pow = tld is "dev"
  
  # Using the above values, decide if we should use LocalStorage
  local = standalone or debug or ck or pow
  
  # Set up the correct backend
  Backend = if local then LocalStorage else Scorm2004
  Backend.initialize()
  Make("Backend", Backend)
