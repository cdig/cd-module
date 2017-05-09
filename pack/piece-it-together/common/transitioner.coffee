# Transitioner


Take ["Vector", "load"], (Vector)->
	
	Make "Transitioner", Transitioner =
		create: (element)->
			throw new Error("Transitioner requires an element") unless element?
			transitioner = {element: element}
			Transitioner.reset(transitioner)
			return transitioner
		
		
		reset: (transitioner)->
			transitioner.transitions = {}
			Transitioner.update(transitioner)
		
		
		add: (transitioner, name = "all", time = "1s", ease = "")=>
			transitioner.transitions[name] =
				time: if isNaN(time) then time else time + "s"
				ease: ease
			Transitioner.update(transitioner)
		
		
		remove: (transitioner, name)=>
			if transitioner.transitions[name]?
				delete transitioner.transitions[name]
				Transitioner.update(transitioner)
		
		
		update: (transitioner)=>
			transitionsList = for property, values of transitioner.transitions
				"#{property} #{values.time} #{values.ease}"
			
			transitionsString = transitionsList.join(",")
			
			# Include all prefixes, so we can transition prefixed properties
			transitioner.element.style['-webkit-transition'] = transitionsString
			transitioner.element.style['-moz-transition'] = transitionsString
			transitioner.element.style['-ms-transition'] = transitionsString
			transitioner.element.style['transition'] = transitionsString
		
		
		afterTransition: (transitioner, callback)=>
			transitioner.element.addEventListener 'transitionend', handler = ()=>
				transitioner.element.removeEventListener 'transitionend', handler
				callback()
