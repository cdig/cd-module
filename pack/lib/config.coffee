# Config
# Aggregates info supplied by various sources at initialization time, making it available behind a unified interface.

Take ["Env", "Params"], (Env, Params)->
  Make "Config", (key)->
    return v if (v = Params key)?
    return v if (v = Env[key])?
    window.config?[key]
