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
      display.className = "score-display-complete" if score >= 1


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
      <circle score-display-disk r="4" cx="10" cy="10"></circle>
      <circle score-display-back r="8" cx="10" cy="10"></circle>
      <circle score-display-ring r="8" cx="10" cy="10"></circle>
    </g>
    <path score-display-check d="M4.78087651,19 L8.20717126,19 C9.64143433,14.7225596 15.2191235,4.51075576 20,0.933259897 C19.0840496,0.640737737 18.1067545,0.406269457 16.4940242,1.77635684e-15 C13.4674935,1.24019577 7.75937204,10.7092455 6.69322715,12.9878649 C5.17928304,13.3767232 3.58565721,10.4991725 3.58565721,10.4991725 L0,12.8323217 C0,12.8323217 3.98406374,17.2112523 4.78087651,19 L4.78087651,19 Z"></path>
  </svg>'