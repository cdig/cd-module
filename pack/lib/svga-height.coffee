Take ["ChildData", "DOMContentLoaded"], (ChildData)->
  
  update = (elm)-> (inbox)->
    elm.style.height = inbox.height if inbox.height?
  
  for elm in document.querySelectorAll "object"
    ChildData.listen elm, update elm
