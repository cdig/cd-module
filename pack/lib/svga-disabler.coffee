Take ["ChildData", "OnScreen", "DOMContentLoaded"], (ChildData, OnScreen)->
  
  update = (elm, visible)->
    ChildData.send elm, "disabled", !visible
  
  for elm in document.querySelectorAll "object"
    OnScreen elm, update
