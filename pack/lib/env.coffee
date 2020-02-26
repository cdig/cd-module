# Env
# Infers information about the current runtime environment.
# Applies an attribute to the html element based on the current environment.

do ()->

  param = location.search.indexOf("dev=true") >= 0
  port = location.port.length > 0

  Make "Env", Object.freeze Env =
    dev: param or port

  if Env.dev
    document.querySelector "html"
            .setAttribute "env-dev", ""
