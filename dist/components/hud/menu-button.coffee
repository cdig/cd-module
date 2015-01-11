# Menu Button

Take ["cdHUD", "SaveWithPopup", "Disconnecter"], (cdHUD, SaveWithPopup, Disconnecter)->
	
	goToLauncher = ()->
		Disconnecter.prevent()
		window.history.back()
	
	button = document.createElement("menu-button")
	button.textContent = "Menu"
	button.addEventListener "click", ()->
		SaveWithPopup (success)->
			if success
				setTimeout(goToLauncher, 500)
	
	cdHUD.addElement(button)
