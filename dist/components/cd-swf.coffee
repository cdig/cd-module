# SWF Embed
# A simple wrapper around SWFObject.
# To use it, make an element like <cd-swf path=""></cd-swf> with the path to your swf.
# Currently designed to work with SWFObject 2.3beta.

Take "load", ()->
	for elm in document.querySelectorAll("[cd-swf]")
		path = elm.getAttribute("cd-swf")
		swfobject.embedSWF("flash/js-wrapper.swf?path=#{path}", elm, "100%", 540, 11.4)
