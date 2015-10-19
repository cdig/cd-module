Take ["cdHUD", "SaveWithPopup"], (cdHUD, SaveWithPopup)->
  
  goToLauncher = ()->
    Disconnecter.prevent()
    window.history.back()
  
  cdHUD.addButton "< Menu", ()->
    SaveWithPopup (success)->
      if success
        setTimeout goToLauncher, 500
  
