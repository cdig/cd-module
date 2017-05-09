# Transformer
# Cross-browser CSS transforms. Nice.

Take ["Vector", "load"], (Vector)->

	Make "Transformer", Transformer = 
		
		create: (element)->
			throw new Error("Transformer requires an element") unless element?
			transform = {element: element}
			Transformer.reset(transform)
			return transform

		reset: (transform)->
			transform.translateString = ""
			transform.translate = Vector.create()
			transform.rotateString = ""
			transform.scaleString = ""
			Transformer.update(transform)
		
		translate: (transform, translation)->
			transform.translate = translation
			transform.translateString = "translate(#{translation.x}px, #{translation.y}px)"
			Transformer.update(transform)
		
		rotate: (transform, rotation)->
			transform.rotateString = "rotate(#{rotation}deg)"
			Transformer.update(transform)
		
		scale: (transform, scaling)->
			transform.scaleString = if isNaN(scaling) then "scale(#{scaling.x}, #{scaling.y})"	else "scale(#{scaling})"
			Transformer.update(transform)
		
		update: (transform)->
			transformString = transform.translateString + " " + transform.rotateString + " " + transform.scaleString
			originString = "top left"
			transform.element.style['-webkit-transform-origin'] = originString
			transform.element.style['-ms-transform-origin'] = originString
			transform.element.style['transform-origin'] = originString
			transform.element.style['-webkit-transform'] = transformString
			transform.element.style['-ms-transform'] = transformString
			transform.element.style['transform'] = transformString

		remove: (transform)->
			transform.element.style['-webkit-transform'] = null
			transform.element.style['-ms-transform'] = null
			transform.element.style['transform'] = null
			transform.element.style['-webkit-transform-origin'] = null
			transform.element.style['-ms-transform-origin'] = null
			transform.element.style['transform-origin'] = null