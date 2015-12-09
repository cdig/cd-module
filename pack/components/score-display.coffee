Take ["cdHUD", "Scoring", "ScoreDisplayGraphic", "ModalPopup", "DOMContentLoaded"], (cdHUD, Scoring, Graphic, ModalPopup)->
  hasActivities = document.querySelector("cd-activity")?
  
  display = document.createElement("score-display")
  display.innerHTML = Graphic
  
  cdHUD.addElement display, ()->
    if hasActivities
      score = Scoring.getModuleScore() * 100 |0
      ModalPopup.open "Progress", "You are #{score}% done the activities in this module."
    else
      ModalPopup.open("Progress", "There are no activities in this module.")
  
  rings = document.querySelectorAll("[score-display-ring]")
  texts = document.querySelectorAll("[score-display-text]")


# UPDATE

  updateDisplay = (score)->
    for ring in rings
      radius = ring.getAttribute("r")
      circumference = 2 * Math.PI * radius
      strokeOffset = (1-score) * circumference
      ring.style.strokeDashoffset = strokeOffset
    for text in texts
      text.innerHTML = (score*100|0) + "<span>%</span>"
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
      <circle score-display-back r="7.5" cx="10" cy="10"></circle>
      <circle score-display-disk r="5.5" cx="10" cy="10"></circle>
      <circle score-display-ring r="7.5" cx="10" cy="10"></circle>
    </g>
    <path score-display-check d="M4,20 L8,20 C9,15 15,5 20,1 C19,1 18,1 16,1 C13,2 7,11 6,13 C5,14 3,10 3,10 L0,12 C0,13 3,18 4,20 Z"></path>
  </svg>
  <div score-display-text></div>'
