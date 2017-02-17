# This fixes table-of-contents links in modules, like the Types of Switches Reference,
# which are otherwise broken because we're injecting a <base> element.

Take "DOMContentLoaded", ()->
  
  jump = (hash)-> ()->
    window.location.hash = hash
  
  for a in document.querySelectorAll "a"
    if a.hash?.length > 0
      a.addEventListener "click", jump a.hash
      a.removeAttribute "href"
