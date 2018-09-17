Take ["AdventureMode", "ChildData", "OnScreen", "DOMContentLoaded"], (AdventureMode, ChildData, OnScreen)->
  return if AdventureMode

  update = (elm, visible)->
    ChildData.send elm, "disabled", !visible

  for elm in document.querySelectorAll "object"
    OnScreen elm, update
