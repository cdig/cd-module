# Menu Button

Take ["cdHUD", "SaveWithPopup", "Disconnecter", "Params"], (cdHUD, SaveWithPopup, Disconnecter, Params)->
  
  # Don't show the menu button unless we've been sent here from the launcher
  return unless Env.parent is "launcher"
  
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
