Take ["cdHUD", "SaveWithPopup"], (cdHUD, SaveWithPopup)->
  
  goToLauncher = ()->
    Disconnecter.prevent()
    window.history.back()
  
  cdHUD.addButton
    text: "⬅︎ Menu"
    order: 1
    click: ()->
      SaveWithPopup (success)->
        if success
          setTimeout goToLauncher, 500
  
