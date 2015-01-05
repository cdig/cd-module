Take ["cdHUD", "BackendLocalStorage", "Backend"], (cdHUD, BLS, Backend)->
	
	# Only show the reset button if we're using BackendLocalStorage
	if BLS is Backend

		reset = document.createElement("div")
		reset.textContent = "Reset"
		
		reset.addEventListener "click", (e)->
			window.localStorage.clear()
		
		cdHUD.addElement(reset)
