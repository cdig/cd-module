Take ["cdHUD", "KVStore", "DOMContentLoaded"], (cdHUD, KVStore)->
  
  doClick = ()->
    success = KVStore.save()
    if success
      window.history.back() # TODO: Should probably use Config.parent (or something) here
    else
      ModalPopup.open "Saving Failed", "Check your internet connection and try again."
  
  
  # Set up buttons in content (eg: in ending.kit)
  for button in document.querySelectorAll "[menu-button]"
    button.addEventListener "click", doClick
  
  # Add a HUD button
  cdHUD.addButton
    text: "⬅︎ Back to Menu"
    order: 1
    click: doClick
