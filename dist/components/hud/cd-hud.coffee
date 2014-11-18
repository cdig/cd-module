do ()->
	hud = document.createElement "cd-hud"
	
	window.addEventListener "load", ()->
		document.body.appendChild(hud)
	
	window.cdHUD =
		addElement: (element)->
			hud.appendChild(element)
