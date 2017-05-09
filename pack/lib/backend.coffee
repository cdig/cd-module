# Backend: LocalStorage
# This service provides the standard Backend API, backed by the browser's LocalStorage.
# It's a very simple backend intended for testing.

do ()->
  KEY = "BackendLocalStorage"
  
  Make "Backend", BackendLocalStorage =
    initialize: ()->
      return true
    
    getPersistedData: ()->
      json = window.localStorage[KEY] or "{}"
      try
        return JSON.parse(json)
      catch e
        console.log json
        return {}
      
      
    
    setPersistedData: (data)->
      if data?
        json = JSON.stringify(data)
        window.localStorage[KEY] = json
        return true
      else
        return false
    
    disconnect: ()->
      return true
    
    complete: ()->
      return true
