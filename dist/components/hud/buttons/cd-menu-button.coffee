do ()->
	button = document.createElement "cd-menu-button"
	button.textContent = "Menu"
	button.addEventListener "click", (e)->
		alert("WOO")
	
	window.addEventListener "load", ()->
		window.cdHUD.addElement(button)
