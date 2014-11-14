easeInOutCubic = (t, b, c, d)=>
	t /= d/2
	if (t < 1) 
		return c/2*t*t*t + b
	t -= 2
	return c/2*(t*t*t + 2) + b
	
linearTween = (t, b, c, d)->
	value = c * t / d + b
	console.log "value is " + value
	return value
