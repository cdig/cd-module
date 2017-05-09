# Params
# Pull all the query params out of the URL and turn them into a hash.
# Also allows setting query params.
# Note: For the sake of "least surprise", we attempt to safely parse all values as numbers or booleans. We don't coerce, though — "TRUE" is still a string.
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
          # This is a crazy hack for detecting numbers, but it seems to be more "right" than any regex I've come across.
          # See here: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_types#Converting_strings_to_numbers
          # It works for all sorts of weird-but-valid numbers, like "-1." and "0b10", and fails for invalid numbers, like "10a"
          +rawVal
        else
          rawVal
  
  rebuildURL = ()->
    url = window.location.href.split("?")[0]
    parts = for k, v of cache
      k + "=" + v
    if parts.length > 0
      url += "?" + parts.join "&"
    history.replaceState null, null, url
  
  Make "Params", Params = (name, value)->
    if value isnt undefined
      if value?
        cache[name] = value
      else
        delete cache[name]
      rebuildURL()
    return cache[name]
