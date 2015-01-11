# Backend: LocalStorage
# This service provides the standard Backend API, backed by the browser's LocalStorage.
# It's a very simple backend intended for testing.
#
# Compatability:
# LocalStorage - IE8
# JSON - IE8

Take "load", ()->
	KEY = "BackendLocalStorage"
	
	Make "BackendLocalStorage", BackendLocalStorage =
		initialize: ()->
			return true
		
		getPersistedData: ()->
			json = window.localStorage[KEY] or "{}"
			return JSON.parse(json)
		
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
