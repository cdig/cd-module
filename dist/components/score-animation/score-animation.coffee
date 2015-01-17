Take ["Particle", "Scoring", "ScoreDisplay", "load"], (Particle, Scoring, ScoreDisplay)->
  POINTS_MAX = 1000
  inactive = []
  active = []
  mousePos =
    x: 0
    y: 0
  targetElement = ScoreDisplay.getElement()
  targetPos =
    x: 0
    y: 0
  currentTime = null
  scoreArea = null
  
  
# DEBUG
  
  # streamOn = false
  # testStream = ()->
  # 	fireParticles(1)
  # 	setTimeout(testStream, 1) if streamOn
  #
  # window.addEventListener "mousedown", ()->
  # 	streamOn = true
  # 	testStream()
  # window.addEventListener "mouseup", ()->
  # 	streamOn = false

  # testParticles = ()->
  # 	fireParticles(200)
  # 	setTimeout(testParticles, 4000)
  
  
# FUNCTIONS
  
  createScoreArea = ()->
    scoreArea = document.createElement("score-area")
  
  
  createParticles = ()->
    for i in [0...POINTS_MAX]
      particleElement = document.createElement("score-point")
      inactive.push(new Particle(particleElement))
      scoreArea.appendChild(particleElement)
  
  
  attachScoreArea = ()->
    document.body.appendChild(scoreArea)


# UPDATES
  
  updateMousePos = (event)->
    mousePos.x = event.clientX
    mousePos.y = event.clientY + window.pageYOffset
  
  
  updateTargetPos = ()->
    tRect = targetElement.getBoundingClientRect()
    targetPos =
      x: tRect.left + tRect.width/2
      y: tRect.top + tRect.height/2 + window.pageYOffset
    
  
  draw = (time)->
    currentTime = time if not currentTime?
    dT = (time - currentTime)/1000
    currentTime = time
    removeParticles = []
    
    for particle in active
      isDone = particle.update(dT, targetPos.x, targetPos.y)
      if isDone
        removeParticles.push(particle)
        inactive.push(particle)
        particle.setInactive()
      else
        particle.draw()
    
    for particle in removeParticles
      index = active.indexOf(particle)
      active.splice(index, 1)
    
    ScoreDisplay.update(active.length)
    
    if active.length > 0
      requestAnimationFrame(draw)
    else
      stopAnimating()
      
  
  startAnimating = ()->
    requestAnimationFrame(draw)
    scoreArea.style.display = "block"
  
  
  stopAnimating = ()->
    currentTime = null
    scoreArea.style.display = "none"
  
  
  fireParticles = (nParticles)->
    points = Math.min(nParticles, inactive.length)
    
    for i in [0...points]
      particle = inactive[i]
      active.push(particle)
      particle.setActive(mousePos.x, mousePos.y)
    
    inactive = inactive.splice(points, inactive.length)
    
    startAnimating() if active.length > 0
  
  
# INITIALIZATION
  
  createScoreArea()
  createParticles()
  attachScoreArea()
  updateTargetPos()
  # setTimeout(testParticles, 2000)

  Scoring.onUpdate(fireParticles)
  
  window.addEventListener("mousemove", updateMousePos)
  window.addEventListener("scroll", updateTargetPos)
  
