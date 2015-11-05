Take ["cdHUD", "KVStore"], (cdHUD, KVStore)->
  
  cdHUD.addButton
    text: "⬅︎ Back to Menu"
    order: 1
    click: ()->
      success = KVStore.save()
      
      if success
        # TODO: Should probably use env.parent (or something) here
        window.history.back()
      else
        ModalPopup.open "Saving Failed", "Check your internet connection and try again."
  
