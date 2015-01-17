Take ["ModalPopup"], (ModalPopup)->
  
  KEY = "WelcomePopup"
  
  container = document.createElement("div")
  container.style.width = "292px"
  
  img = document.createElement("img")
  img.src = "data:image/png;base64,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"
  img.style["margin-bottom"] = "-50px"
  container.appendChild(img)
  
  text = document.createTextNode("In the bottom left corner, you'll find buttons that
    take you back to the main menu, turn voice-over narration on and off, or quickly switch pages.")
  container.appendChild(text)
  
  if not window.localStorage[KEY]?
    window.localStorage[KEY] = true
    ModalPopup.open("Welcome", container)
