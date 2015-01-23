# Flash Interface
#
# Yep, this stuff needs to be out in the open, polluting the global namespace. Gross. Sorry.

window.hasAPI = ()->
  return true

Take "Scoring", (Scoring)->
  window.awardPoints = (percent, exact, name)->
    if percent?
      Scoring.addScore(name, percent)
    if exact?
      Scoring.addPoints(name, exact)
    return true
