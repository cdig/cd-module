# cd-swf
# A simple wrapper around SWFObject.
# Currently designed to work with SWFObject 2.3beta.

Take "load", ()->
  for elm in document.querySelectorAll("[cd-swf]")
    path = elm.getAttribute("cd-swf")
    transcludeContent = elm.innerHTML
    swfobject.embedSWF "flash/js-wrapper.swf?path=#{path}", elm, "100%", 540, 11.4, false, false, false, false, (e)->
      e.ref.innerHTML = transcludeContent if e.success
