Take ["Channel", "OnScreen", "DOMContentLoaded"], (Channel, OnScreen)->
  
  update = (object, visible)->
    Channel object, "disabled", visible
  
  for object in document.querySelectorAll "object"
    OnScreen object, update
