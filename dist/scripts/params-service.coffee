# Params
# Pull all the query params out of the URL and turn them into a hash.

do ()->
  
  params = {}
  search = window.location.search
  paramStrings = search.substr(1).split("&")
  
  for paramString in paramStrings
    paramParts = paramString.split("=")
    params[paramParts[0]] = decodeURIComponent(paramParts[1] or true)
  
  Object.freeze(params)
  
  Make("Params", params)
