# Flash Interface
#
# Yep, this stuff needs to be out in the open, polluting the global namespace. Gross. Sorry.

window.hasAPI = ()->
  return true

Take "Scoring", (Scoring)->
  window.awardPoints = (eid, name, percent, exact)->
    element = document.getElementById(eid)
    
    if percent? > 0
      Scoring.addScore(name, percent)
    if exact? > 0
      Scoring.addPoints(name, exact)
    return true
