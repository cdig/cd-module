Take "DOMContentLoaded", ()->
  huds = document.querySelectorAll "cd-hud"
  
  Make "cdHUD", cdHud =
    
    # To control sort order of elements in the hud, use the flexbox 'order' property
    
    addElement: (element, clickHandler)->
      for hud in huds
        clone = element.cloneNode true
        if clickHandler?
          clone.addEventListener "click", clickHandler
        hud.appendChild clone
        clone
    
    addButton: (text, clickHandler)->
      button = document.createElement "div"
      button.setAttribute "cd-hud-button", true
      button.innerHTML = text
      buttons = cdHud.addElement button, clickHandler
