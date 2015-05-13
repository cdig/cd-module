Take ["cdHUD", "MuteAnimation", "PageAudio", "Params",  "load"], (cdHUD, MuteAnimation, PageAudio, Params)->
  
  # Don't show the mute button unless audio is enabled
  return unless Params.audio
  PageAudio.enable() #we want page audio by default to be on, so enable it as soon as the mute button loads
# GRAPHIC (experimental approach using <template> element)
  
  graphicTemplate = document.getElementById("mute-button-graphic")
  if graphicTemplate.content?
    graphicFragment = document.importNode(graphicTemplate.content, true)
    graphic = graphicFragment.querySelector("svg")
  else
    graphic = graphicTemplate.querySelector("svg")
  
  
# BUTTON
  
  button = document.createElement("mute-button")
  button.addEventListener("click", PageAudio.toggle)
  button.appendChild(graphic)
  cdHUD.addElement(button)
  
  
# FUNCTIONS
  
  update = ()->
    if PageAudio.isEnabled()
      MuteAnimation(graphic, false)
      
    else
      MuteAnimation(graphic, true)
  
  
# INITIALIZATION
  
  PageAudio.onUpdate(update)
  update()
