# cd-swf
# A simple wrapper around SWFObject.
# Currently designed to work with SWFObject 2.3beta.

Take "load", ()->
  
  idCounter = 0
  
# FUNCTIONS
  
  setupSwf = (elm, fallback)->
    path = elm.getAttribute("cd-swf")
    transcludeContent = elm.innerHTML
    
    # This nonsense with IDs is needed because SWFObject removes our element from the dom,
    # makes a new <object> element, and only copies over SOME attributes (like id).
    # So we generate IDs dynamically so that we can get a hold of the new <object> it generates.
    if not elm.id? or elm.id is ""
      elm.id = "cd-swf-" + idCounter++
    
    eid = elm.id
    
    swfobject.embedSWF "flash/js-wrapper.swf?path=#{path}&eid=#{eid}", eid, "100%", 540, 11.4, false, false, false, false, ()->
      newElm = document.getElementById(eid)
      newElm.innerHTML = transcludeContent
      newElm.appendChild(fallback)
      # Make sure the cd-swf attribute is still present, so we can track that this SWF was added properly (for Warnings, etc)
      newElm.setAttribute("cd-swf")
  
  
# INITIALIZATION
  
  fallback = document.querySelector("cd-swf-fallback")
  cdSwfs = document.querySelectorAll("[cd-swf]")
  setupSwf(elm, fallback.cloneNode(true)) for elm in cdSwfs
