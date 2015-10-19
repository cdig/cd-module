Take "DOMContentLoaded", ()->
  
# ELEMENTS
  
  main = document.createElement("cd-modal")
  popup = document.createElement("modal-popup")
  title = document.createElement("h1")
  content = document.createElement("div")
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
        content.innerHTML = "<div>#{givenContent}</div>"
      else
        content.innerHTML = ""
        content.appendChild givenContent
      
      main.className = "show"
      buttons.style.visibility = if showButtons then null else "hidden"

    
    close: ()->
      fadeOut()
  
  
# PRIVATE
  
  fadeOut = ()->
    main.className = "hiding"
    setTimeout(hide, 500)
  
  
  hide = ()->
    main.className = "hide"
  
  
  handleOkayClick = ()->
    fadeOut()
  
# INIT
  
  okayButton.addEventListener("click", handleOkayClick)
  hide()
