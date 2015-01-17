# Compat:
# IE10 — Transitions

Take "load", ()->
  
# ELEMENTS
  
  main = document.createElement("cd-modal")
  popup = document.createElement("modal-popup")
  title = document.createElement("h1")
  content = document.createElement("p")
  buttons = document.createElement("modal-buttons")
  okayButton = document.createElement("okay-button")

  okayButton.textContent = "Okay"
  
  buttons.appendChild(okayButton)
  popup.appendChild(title)
  popup.appendChild(content)
  popup.appendChild(buttons)
  main.appendChild(popup)
  document.body.appendChild(main)
  
  
# PUBLIC
  
  Make "ModalPopup",
    
    open: (givenTitle, givenContent, showButtons = true)->
      title.textContent = givenTitle
      
      if typeof givenContent is "string"
        content.textContent = givenContent
      else
        while content.hasChildNodes()
          content.removeChild(content.lastChild)
        content.appendChild(givenContent)
      
      main.className = "show"
      
      if showButtons
        buttons.style.visibility = null
      else
        buttons.style.visibility = "hidden"
    
    
    close: ()->
      fadeOut()
  
  
# PRIVATE
  
  fadeOut = ()->
    main.className = "hiding"
    setTimeout(hide, 500)
  
  
  hide = ()->
    main.className = "hide"
  
  
# INIT
  
  okayButton.addEventListener("click", fadeOut)
  hide()
