do ()->
	SCALE = 1.5
	MAX_TRAVEL_TIME = 1.6 * SCALE # How long does it take to get to the score indicator
	MIN_TRAVEL_TIME = 1.2 * SCALE
	MAX_SCATTER_SPEED = 240 / SCALE # How quickly do the points spread out from their initial position
	MIN_SCATTER_SPEED = 180 / SCALE
	
	
	addVectors = (v0, v1)->
		return v =
			x: v0.x + v1.x
			y: v0.y + v1.y
	
	scalarMultiply = (vec, scalar)->
		return v =
			x: vec.x * scalar
			y: vec.y * scalar
	
	map = (input, inputMin, inputMax, outputMin, outputMax, clip = false)->
		input = Math.max(Math.min(input, inputMax), inputMin) if clip
		input -= inputMin
		input /= inputMax - inputMin
		input *= outputMax - outputMin
		input += outputMin
		return input
	
	
	Make "Particle", class Particle
		element: null
		x: 0
		y: 0
		pos: 0
		scale: 0
		travelSpeed: 0.0
		scatterSpeed: 0.0
		scatterAngle: 0.0
		scatterForce: null
		scatterTrajectory: null
		target: null
		
		
		constructor: (@element)->
			@setInactive()
		
		setActive: (sX, sY)=>
			@pos = 0
			@x = sX
			@y = sY
			@scatterTrajectory = { x: sX, y: sY }
			
			rand = Math.random()
			
			@travelSpeed = 1 / map(Math.random(), 0, 1, MIN_TRAVEL_TIME, MAX_TRAVEL_TIME)
			@scatterSpeed = map(Math.random(), 0, 1, MIN_SCATTER_SPEED, MAX_SCATTER_SPEED)
			@scatterAngle = map(Math.random(), 0, 1, 0, 2 * Math.PI)
			@scatterForce =
				x: Math.cos(@scatterAngle) * @scatterSpeed
				y: Math.sin(@scatterAngle) * @scatterSpeed
		
		
		setInactive: ()=>
			@x = -999
			@y = -999
			@scale = 0
			@draw()
		
			
		update: (dT, targetX, targetY)=>
			@pos += @travelSpeed * dT
			@pos = Math.min(@pos, 1)
			@scatterTrajectory = addVectors(@scatterTrajectory, scalarMultiply(@scatterForce, dT))
			@x = map(@pos*@pos, 0, 1, @scatterTrajectory.x, targetX)
			@y = map(@pos*@pos*@pos*@pos, 0, 1, @scatterTrajectory.y, targetY)
			@scale = map(Math.sin(@pos * Math.PI * 8), -1, 1, 0.2, 1.2)
			return @pos >= 1
		
		
		draw: ()=>
			x = @x
			y = @y
			transString = "translate3d(#{@x}px, #{@y}px, 0px) scale(#{@scale})"
			@element.style.webkitTransform = transString
			@element.style.transform = transString
