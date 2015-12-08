Take ["Config", "DOMContentLoaded"], (Config)->
  hud = document.querySelector "cd-hud"
  buttons = hud.querySelector ".cd-hud-buttons"
  
  if Config "hide-hud"
    hud.style.display = "none"
  
  Make "cdHUD", cdHud =
    
    # To control sort order of elements in the hud, use the flexbox 'order' property
    
    addElement: (element, clickHandler)->
      clone = element.cloneNode true
      if clickHandler?
        clone.addEventListener "click", clickHandler
      buttons.appendChild clone
      clone
    
    # Options: text (string), order (int), click (fn)
    addButton: (options)->
      button = document.createElement "div"
      button.className = "lbs-button"
      button.setAttribute "cd-hud-button", true
      button.setAttribute(options.attr, true) if options.attr?
      button.innerHTML = options.text
      button.style.order = options.order
      cdHud.addElement button, options.click
