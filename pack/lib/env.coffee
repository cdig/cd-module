# Env
# Infers information about the current runtime environment.
# Applies an attribute to the html element based on the current environment.

do ()->
  
  parts = location.hostname.split(".")
  tld = parts[parts.length-1]
  
  pow = tld is "test"
  port = location.port.length > 0
  
  Make "Env", Object.freeze Env =
    dev: pow or port
  
  if Env.dev
    document.querySelector "html"
            .setAttribute "env-dev", ""
