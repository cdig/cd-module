# Backend: SCORM 2004
# This service wraps the SCORM 2004 API and exposes a standard interface to the rest of the system.


Take "load", ()->
	scormAPI = null
	connected = false
	lastErrorCode = null
	
	Make "BackendScorm2004", BackendScorm2004 =
		initialize: ()->
			try
				setupScormAPI()
				if initialize()
					setupStatuses()
					setupNavigation()
				return true
			catch error
				Take "ModalPopup", (ModalPopup)-> ModalPopup.open("Error", error.errorMessage, false)
				return false
		
		getPersistedData: ()->
			json = getValue("cmi.suspend_data") || "{}"
			return JSON.parse(json)
		
		setPersistedData: (data)->
			json = JSON.stringify(data)
			success = setValue("cmi.suspend_data", json)
			return success and commit()
		
		disconnect: ()->
			commit() # Ensures that our navigation status (etc) is saved
			disconnect()
		
		complete: ()->
			# Assumption: we should only set a score on completion, and not when the user is incomplete
			s = setValue("cmi.score.scaled", 1)
			m = setValue("cmi.score.min", 0)
			M = setValue("cmi.score.max", 1)
			r = setValue("cmi.score.raw", 1)
			
			c = setValue("cmi.completion_status", "completed")
			p = setValue("cmi.success_status", "passed")
			
			return s and m and M and r and c and p and commit()
			
	
# SETUP
	
	setupScormAPI = ()->
		return if (scormAPI = findScormAPIObject(window))?
		return if (scormAPI = findScormAPIObject(window.top?.opener))?
		return if (scormAPI = findScormAPIObject(window.top?.opener?.document))? # Special handling for Plateau
		throw new Error("SCORM 2004 API not found")
	
	
	initialize = ()->
		switch scormGet("Initialize", "", true)
			when true
				console.log("SCORM Initialize: success")
				connected = true
				return true
			when false
				console.log("SCORM Initialize: already initialized")
				connected = true
				return false
			else
				throw new Error("SCORM 2004 Initialize caused an error")
			
		
		
	setupStatuses = ()->
		setValue("cmi.exit", "suspend")
		status = getValue("cmi.completion_status")
		if status isnt "completed"
			setValue("cmi.completion_status", "incomplete")
		
	
	setupNavigation = ()->
		setValue("adl.nav.request", "suspendAll")
	
	
# HIGH LEVEL WRAPPED SCORM NICENESS
	
	getValue = (parameter)->
		return scormGet("GetValue", parameter)
	
	
	setValue = (parameter, value)->
		return scormSet("SetValue", parameter, value)
	
	
	commit = ()->
		return scormGet("Commit", "")
	
	
	disconnect = ()->
		if connected and scormGet("Terminate", "")
			connected = false
		return !connected
		
	
# LOW LEVEL RAW SCORM UGLINESS
	
	findScormAPIObject = (context)->
		if context?
			findAttempts = 10
			while findAttempts-- > 0
				switch
					when context.API_1484_11? 			then return context.API_1484_11
					when not context.parent? 				then return null
					when context.parent is context	then return null
					else context = context.parent
		
	
	scormGet = (name, parameter, force = false)->
		failureMsg = "API.#{name}(#{parameter}) failed:"
		clearLastError()
		
		if connected or force
			result = String(scormAPI[name](parameter))
			if getSucceeded(result)
				return result
			else
				failure(failureMsg)
				return null
		
		else
			console.log("#{failureMsg} Not Connected")
	
	
	scormSet = (name, parameter, value, force = false)->
		failureMsg = "API.#{name}(#{parameter}, #{value}) failed:"
		clearLastError()
		
		if connected or force
			result = String(scormAPI[name](parameter, value))
			if setSucceeded(result)
				return true
			else
				failure(failureMsg)
				return false

		else
			console.log("#{failureMsg} Not Connected")
	

	clearLastError = ()->
		lastErrorCode = null

	
	getLastError = ()->
		return lastErrorCode ?= parseInt(scormAPI.GetLastError(), 10)


	hasNoError = ()->
		return getLastError() is 0
	
	
	getSucceeded = (value)->
		hasValue = value? and value isnt ""
		return hasValue or hasNoError()
	
	
	setSucceeded = (value)->
		switch typeof value
			when "object", "string" then (/(true|1)/i).test(value)
			when "number" then Boolean(value)
			when "boolean" then value
			else false
	
	
	failure = (message)->
		errorCode = getLastError()
		errorString = scormAPI.GetErrorString(String(errorCode))
		diagnostics = scormAPI.GetDiagnostic(String(errorCode))
		console.log(message)
		console.log("  Code: #{errorCode}")
		console.log("  Message: #{errorString}")
		console.log("  Diagnostics: #{diagnostics}")
