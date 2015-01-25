Take ["ModalPopup", "cdHUD"], (ModalPopup, cdHUD)->
  
  KEY = "cdModuleWelcomePopup"
  
  container = document.createElement("div")
  container.style.width = "292px"
  
  hud = cdHUD.getContainer().cloneNode(true)
  container.appendChild(hud)
  
  text = document.createTextNode("In the bottom left corner, you'll find the HUD. Use it to control the various special features of this lesson.")
  container.appendChild(text)
  
  if not window.localStorage[KEY]?
    window.localStorage[KEY] = true
    ModalPopup.open("Welcome", container)
