# cd-swf
# A simple wrapper around SWFObject.
# Currently designed to work with SWFObject 2.3beta.

Take "load", ()->

# FUNCTIONS
  
  setupSwf = (elm, fallback)->
    path = elm.getAttribute("cd-swf")
    transcludeContent = elm.innerHTML
    swfobject.embedSWF "flash/js-wrapper.swf?path=#{path}", elm, "100%", 540, 11.4, false, false, false, false, ()->
      elm.innerHTML = transcludeContent
      elm.appendChild(fallback)
  
  
# INITIALIZATION
  
  fallback = document.querySelector("cd-swf-fallback")
  cdSwfs = document.querySelectorAll("[cd-swf]")
  setupSwf(elm, fallback.cloneNode(true)) for elm in cdSwfs
