# Config
# Aggregates info supplied by various sources at initialization time, making it available behind a unified interface.

window.config ?= {}

Take ["Env", "Params"], (Env, Params)->
  
  Make "Config", (key, value)->
    if value isnt undefined
      Params key, value
    else
      return v if (v = Params key)?
      return v if (v = Env[key])?
      window.config[key]
