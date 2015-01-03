Take ["cdHUD", "PageAudio", "load"], (cdHUD, PageAudio)->
	
	button = document.createElement("mute-button")
	graphic = document.querySelector("mute-button-graphic").firstChild
	button.appendChild(graphic)
	cdHUD.addElement(button)
	
	button.addEventListener "click", PageAudio.toggle
	
	
	PageAudio.onUpdate (enabled)->
		if enabled
			graphic.className = ""
		else
			graphic.className = "muted"
