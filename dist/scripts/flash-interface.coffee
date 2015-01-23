# Flash Interface
#
# Yep, this stuff needs to be out in the open, polluting the global namespace. Gross. Sorry.

window.hasAPI = ()->
  return true

Take "Scoring", (Scoring)->
  window.awardPoints = (percent, exact, name)->
    if percent? > 0
      Scoring.addScore(name, percent)
    if exact? > 0
      Scoring.addPoints(name, exact)
    return true
