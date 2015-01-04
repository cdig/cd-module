# SWF Embed
# A simple wrapper around SWFObject.
# To use it, make an element like <cd-swf path=""></cd-swf> with the path to your swf.
# Currently designed to work with SWFObject 2.3beta.

Take "load", ()->
	for elm in document.querySelectorAll("cd-swf")
		path = elm.getAttribute("path")
		swfobject.embedSWF("flash/JS Wrapper.swf?path=#{path}", elm, 960, 540, 11.4)
