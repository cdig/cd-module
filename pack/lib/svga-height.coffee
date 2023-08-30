Take ["AdventureMode", "ChildData", "DOMContentLoaded"], (AdventureMode, ChildData)->
  return if AdventureMode

  update = (elm)-> (inbox)->
    elm.style.height = inbox.height if inbox.height?

  for elm in document.querySelectorAll "object"
    ChildData.listen elm, update elm
    ChildData.send elm, "windowTopInnerHeight", window.top.innerHeight