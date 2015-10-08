Take ["ModalPopup", "cdHUD"], (ModalPopup, cdHUD)->
  
  KEY = "cdModuleWelcomePopup"
  
  
# SETUP
  
  createAndOpenWelcomePopup = ()->
    
    container = document.createElement("center-block")
    container.className = "WelcomePopupContainer"
    
    topText = document.createElement("p")
    topText.textContent = "In the bottom left corner is the HUD"
    container.appendChild(topText)
    
    hud = cdHUD.getContainer().cloneNode(true)
    container.appendChild(hud)
    
    bottomText = document.createElement("p")
    bottomText.textContent = "You can use it to control this module"
    container.appendChild(bottomText)
    
    ModalPopup.open("Welcome", container)
  
  
# INITIALIZATION
  
  if not window.localStorage[KEY]?
    window.localStorage[KEY] = true
    
    # Delay the setup by one turn of the event loop, so we have a
    # better chance of catching all the items being added to the HUD. This is a hack.
    setTimeout(createAndOpenWelcomePopup)
