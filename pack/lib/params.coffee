# Params
# Pull all the query params out of the URL and turn them into a hash.
# Also allows setting query params.
# Note: For the sake of "least surprise", we attempt to safely parse all values as numbers or booleans. We don't coerce, though — "TRUE" is still a string.
# Note: because of the HTML history API, these values might change at runtime! We decidedly don't care about that (for now).

do ()->

  cache = {}

  search = window.location.search
  if search.length > 1
    for paramString in search.substr(1).split("&")
      paramParts = paramString.split("=")
      key = paramParts[0]
      rawVal = decodeURIComponent(paramParts[1] or true)
      cache[key] = switch
        when rawVal is "true"
          true
        when rawVal is "false"
          false
        when not isNaN (+rawVal)
          +rawVal # https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_types#Converting_strings_to_numbers
        else
          rawVal

  rebuildURL = ()->
    origin = window.location.origin
    path = window.location.pathname
    hash = window.location.hash
    search = (k + "=" + v for k, v of cache).join "&"
    url = origin + path
    url += "?#{search}" if search?.length > 0
    url += hash if hash?.length > 0
    history.replaceState null, null, url

  Make "Params", Params = (name, value)->
    if value isnt undefined

      if value? and cache[name] isnt value
        cache[name] = value
        rebuildURL()

      if !value? and cache[name]?
        delete cache[name]
        rebuildURL()

    return cache[name]
