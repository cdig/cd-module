Take ["KVStore", "Params", "PureDom"], (KVStore, Params, PureDom)->
  SCORING_API_VERSION = 1
  hasActivities = document.querySelector("cd-activity")?
  projectNode = null
  chapterNode = null
  moduleNode = null
  updateCallbacks = []
  
  
# PUBLIC
  
  makeAPI = ()->
    Make "Scoring",
      addPoints: (cdActivity, points)->
        if hasActivities
          console.assert(cdActivity.matches("cd-activity"), "Scoring.addPoints(cdActivity, points) must be called with a cd-activity element, not:", cdActivity)
          activityNode = findActivitiyNodeFor(cdActivity)
          applyAward(activityNode, points)
        
      addScore: (cdActivity, score)->
        if hasActivities
          console.assert(cdActivity.matches("cd-activity"), "Scoring.addScore(cdActivity, score) must be called with a cd-activity element, not:", cdActivity)
          activityNode = findActivitiyNodeFor(cdActivity)
          points = score * activityNode.totalPoints
          applyAward(activityNode, points)
      
      getActivityScore: (cdActivity)->
        console.assert(cdActivity.matches("cd-activity"), "Scoring.getActivityScore(cdActivity) must be called with a cd-activity element, not:", cdActivity)
        activityNode = findActivitiyNodeFor(cdActivity)
        return activityNode.score
      
      getPageScore: (page)->
        pageId = page.id
        pageNode = moduleNode.pages[pageId]
        return pageNode?.score
      
      getModuleTotalPoints: ()->
        return moduleNode.totalPoints
      
      getModuleScore: ()->
        return moduleNode.score
      
      onUpdate: (callback)->
        updateCallbacks.push(callback)
    
    

# IMMUTABLE
  
  createScoringNode = (groupName, nodeDefaults)->
    node = nodeDefaults or {}
    node.score = 0
    node[groupName] = {} if groupName?
    return node
  
  
  findActivitiyNodeFor = (cdActivity)->
    activityName = cdActivity.getAttribute("name")
    pageElement = PureDom.querySelectorParent(cdActivity, "cd-page")
    pageId = pageElement.id
    return moduleNode.pages[pageId].activities[activityName]
    
    
  runCallbacks = (pointsAwarded)->
    call(pointsAwarded) for call in updateCallbacks
      

# MUTATION
  
  loadScoringTree = ()->
    projectNode = KVStore.get(Params.project) or createScoringNode("chapters")
    chapterNode = projectNode.chapters[Params.chapter] ?= createScoringNode("modules")
    moduleNode = chapterNode.modules[Params.module] ?= createScoringNode("pages", {v: SCORING_API_VERSION})
    
    # If we've found an out-of-date version of the module scores, wipe them and start over
    if not moduleNode.v or moduleNode.v < SCORING_API_VERSION
      console.log "Out of date scores found — erasing"
      moduleNode = chapterNode.modules[Params.module] = createScoringNode("pages")
      moduleNode.v = SCORING_API_VERSION
    
  
  crawlModuleAndSetUpScoring = ()->
    # Recompute the total points, as they may have changed
    moduleNode.totalPoints = 0
    
    for page in document.querySelectorAll("cd-page")
      pageActivities = page.querySelectorAll("cd-activity")
      
      # Don't add a node for a page unless it has activities
      if pageActivities.length > 0
        
        pageId = page.id
        pageNode = moduleNode.pages[pageId] ?= createScoringNode("activities")
        # Recompute the total points, as they may have changed
        pageNode.totalPoints = 0
        
        for activityElement in pageActivities
          activityName = activityElement.getAttribute("name")
          activityPoints = parseInt(activityElement.getAttribute("points"))
          activityNode = pageNode.activities[activityName] ?= createScoringNode()
          
          # Always overwrite and recompute these, because the points attribute may have changed
          activityNode.totalPoints = activityPoints
          activityNode.earnedPoints = activityPoints * activityNode.score
          pageNode.totalPoints += activityPoints
          moduleNode.totalPoints += activityPoints
  
  
  applyAward = (activityNode, pointsToAward)->
    return if activityNode.score >= 1
    
    pointsBefore = activityNode.earnedPoints
    
    activityNode.earnedPoints += pointsToAward
    activityNode.earnedPoints = Math.min(activityNode.earnedPoints, activityNode.totalPoints)
    
    activityNode.score = activityNode.earnedPoints / activityNode.totalPoints
    activityNode.score = Math.round(10000 * activityNode.score)/10000 # Corrects floating point errors
    
    pointsAwarded = activityNode.earnedPoints - pointsBefore
    
    updateModuleScore()
    saveScoringTree()
    runCallbacks(pointsAwarded)
  
  
  updateModuleScore = ()->
    moduleNode.earnedPoints = 0

    for pageName, pageNode of moduleNode.pages
      pageNode.earnedPoints = 0
      
      for activityName, activityNode of pageNode.activities
        pageNode.earnedPoints += activityNode.earnedPoints
      
      moduleNode.earnedPoints += pageNode.earnedPoints
      pageNode.score = pageNode.earnedPoints / pageNode.totalPoints
    
    moduleNode.score = moduleNode.earnedPoints / moduleNode.totalPoints
    
  
  saveScoringTree = ()->
    KVStore.set(Params.project, projectNode)
    
    
# SETUP
  
  loadScoringTree()
  if hasActivities
    crawlModuleAndSetUpScoring()
    updateModuleScore()
    saveScoringTree()
    runCallbacks(0)
  makeAPI()