Take ["cdHUD", "Scoring", "ScoreDisplayGraphic", "ModalPopup", "DOMContentLoaded"], (cdHUD, Scoring, Graphic, ModalPopup)->
  hasActivities = document.querySelector("cd-activity")?
  
  display = document.createElement("score-display")
  display.innerHTML = Graphic
  
  cdHUD.addElement display, ()->
    if hasActivities
      score = Math.round Scoring.getModuleScore() * 100
      ModalPopup.open "Progress", "You are #{score}% done the activities in this module."
    else
      ModalPopup.open("Progress", "There are no activities in this module.")
  
  rings = document.querySelectorAll("[score-display-ring]")


# UPDATE

  updateDisplay = (score)->
    for ring in rings
      radius = ring.getAttribute("r")
      circumference = 2 * Math.PI * radius
      strokeOffset = (1-score) * circumference
      ring.style.strokeDashoffset = strokeOffset
    if score >= 1
      for display in document.querySelectorAll("score-display")
        display.className = "score-display-complete"


# INITIALIZE
  
  if hasActivities
    updateDisplay(Scoring.getModuleScore())
  else
    updateDisplay(1)
  
  Scoring.onUpdate ()->
    updateDisplay(Scoring.getModuleScore())

Make "ScoreDisplayGraphic",
  '<svg viewBox="0 0 20 20" preserveAspectRatio="xMidYMid meet" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <g score-display-progress>
      <circle score-display-back class="glass" r="8" cx="10" cy="10"></circle>
      <circle score-display-disk r="4" cx="10" cy="10"></circle>
      <circle score-display-ring r="8" cx="10" cy="10"></circle>
    </g>
    <path score-display-check d="M4.78,19 L8.2,19 C9.64,14.72 15.21,4.51 20,0.93 C19.08,0.64 18.1,0.40 16.49,0 C13.46,1.24 7.75,10.70 6.69,12.98 C5.17,13.37 3.58,10.5 3.58,10.5 L0,12.83 C0,12.83 3.98,17.21 4.78,19 L4.78,19 Z"></path>
  </svg>'
