# Disconnecter
# To make SCORM work, we need to disconnect when the window is closed. However, we don't want to
# disconnect if we're going back to the launcher. Thus, when we link to the launcher, the MenuButton
# calls Disconnecter.prevent() to prevent the disconnect action.

Take "Backend", (Backend)->
	disconnectPrevented = false
	
	Make "Disconnecter", Disconnecter
		prevent: ()->
			disconnectPrevented = true
	
	Take "unload", ()->
		unless disconnectPrevented
			Backend.disconnect()
