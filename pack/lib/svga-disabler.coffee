Take "OnScreen", (OnScreen)->
  
  update = (object, visible)->
    object.disableSVGA = not visible
  
  for object in document.querySelectorAll "object"
    OnScreen object, update
