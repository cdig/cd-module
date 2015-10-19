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
    
    # Accepts: text, order, click
    addButton: (options)->
      button = document.createElement "div"
      button.setAttribute "cd-hud-button", true
      button.innerHTML = options.text
      button.style.order = options.order
      buttons = cdHud.addElement button, options.click
