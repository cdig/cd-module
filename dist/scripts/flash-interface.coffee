# Flash Interface
# Yep, this stuff needs to be out in the open, polluting the global namespace. Gross. Sorry.

window.hasAPI = ()->
  return true

Take ["PureDom", "Scoring"], (PureDom, Scoring)->
  window.awardPoints = (eid, name, percent, exact)->
    percent = parseFloat(percent)
    exact = parseInt(exact)
    
    # Sometimes, the name might include an extension, due to a bug in js-wrapper
    # This is a quick workaround
    name = name.replace(".swf", "")
    
    element = document.getElementById(eid)
    page = PureDom.querySelectorParent(element, "cd-page")
    cdActivity = page.querySelector("cd-activity[name='#{name}']")
    
    if percent? and percent > 0
      Scoring.addScore(cdActivity, percent)
    
    if exact? and exact > 0
      Scoring.addPoints(cdActivity, exact)
    
    return true
