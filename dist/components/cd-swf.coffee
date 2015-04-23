# cd-swf
# A necessary-evil wrapper around SWFObject.
# Currently designed to work with SWFObject 2.3beta.

Take ["PureDom", "load"], (PureDom)->
  idCounter = 0
  
  setupSwf = (elm, fallbackContent)->
    
    # SWFObject removes our <object> element from the dom, makes a new <object> element,
    # and copies over SOME attributes (like id). To keep track of the new <object>,
    # we'll make sure that current <object> has an ID, by generating a new unique ID if necessary.
    if not elm.id? or elm.id is ""
      elm.id = "cd-swf-" + idCounter++
    
    # Store the element's ID, so that we can find the <object> after SWFObject finishes with it
    eid = elm.id
    
    # Capture the content inside the current <object> before SWFObject destroys it.
    # This should preserve custom params, eg: <object cd-swf="foo"><param name="bgcolor" value="red"></object>
    # Note: this behaviour (transcluding custom params) is untested and may not work!
    transcludeContent = PureDom.nodeListToArray(elm.childNodes)
    
    # We don't actually load the SWF. We load the js-wrapper, and pass it the path to the SWF.
    path = elm.getAttribute("cd-swf")
    
    # Engage!
    swfobject.embedSWF "flash/js-wrapper.swf?path=#{path}&eid=#{eid}", eid, "100%", 540, 11.4, false, false, { wmode: "opaque" }, false, ()->

      # Now, find and set up the new <object> element created by SWFObject
      newElm = document.getElementById(eid)
      newElm.appendChild(node) for node in transcludeContent
      newElm.appendChild(fallbackContent)
      
      # Make sure the cd-swf attribute is still present, so we can track that this SWF was added properly (for Warnings, etc)
      newElm.setAttribute("cd-swf", "")
  
  
# INITIALIZATION

  cdSwfs = document.querySelectorAll("[cd-swf]")
  
  # The fallback content shows up when the user's browser doesn't have the Flash Player (eg: mobile)
  fallback = document.querySelector("cd-swf-fallback")
  
  for elm in cdSwfs
    # We need to generate a new copy of the fallback content for each SWF
    # if we don't wrap this call in a closure in IE10 we run into issues
    # when embedding multiple SWF files. Race conditions sometimes stop flash from
    # loading. The timeout and closure resolve this.
    closure = (elm)->
      setTimeout ()=>
        clonedFallback = fallback.cloneNode(true)
        setupSwf(elm, clonedFallback)
      , 1
    closure elm  
