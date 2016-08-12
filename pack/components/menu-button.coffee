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
  
  # Add a HUD Element
  menuButton = document.createElement "menu-button"
  menuButton.innerHTML = """
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 150">
      <path fill="#FFF" fill-opacity=".85" d="M51 112q5.3 3 10 5l3.7-7q-8.7-3-15.1-7-4.6-2.6-9.1-6L10 107.7q-1.6-1.7-2.4-2.4Q6 104 5 102.4q-3-4-5-10.4 1 9 4 15 3 5 8 9.3l29-10.6q4 3.3 10 6.3M29 67L2.5 64.7 4 72l24 2v-3.3q.3-1.3 1-3.7m140.3 35.7l28.1 8.9 2.6-7.6-30.3-9q-5.7 7-16.7 12.5l5 5q4.4-2.8 7-5.2 2-1.9 4.3-4.6m5.1 26.9q-6.4 3.7-12.4 6-7 2.8-15.4 4.4L127 115.3q-9 1.2-15 1.4-7 .3-16.4-.4L85.3 142q-10.9-1-20.7-3.5-7.6-2-13.6-4.5l.3 8q8.3 3.5 16.7 5.3 6.7 1.7 17 2.7l10-25.6q18 1.3 31.5-.9L145 148q7.5-1.6 14-4 7.7-2.7 13-6l2.4-8.4M173 73l17-2 2-6.3-21 2.3q1 1.6 1.3 3 .7 1 .7 3zm-7-24l2-20-7-18h-15l-5-11H67l-5 11H47l-7 18 2 20h5l4 45h106l4-45h5M136 5l3 6H69l3-6h64M67 42h11l1 18H68l-1-18m63 0h11l-1 18h-11l1-18z"/>
      <path fill="#FFF" fill-opacity=".3" d="M166 49l2-20-7-18h-15l1 2h-7l-1-2H69l-1 2h-7l1-2H47l-7 18 2 20h25.4l-.4-7h11l.4 7h51.2l.4-7h11l-.4 7H166z"/>
    </svg>
    <span>Back to Menu</span>
    """
  menuButton.style.order = 1
  cdHUD.addElement menuButton, doClick
