# window.localStorage.clear()

Take ["KVStore", "Params", "PureDom"], (KVStore, Params, PureDom)->
	hasActivities = document.querySelector("cd-activity")?
	moduleTotalPoints = 0
	projectNode = null
	chapterNode = null
	moduleNode = null
	updateCallbacks = []
	
	
# PUBLIC
	
	makeAPI = ()->
		Make "Scoring",
			addPoints: (target, points)->
				if hasActivities
					activityNode = findActivitiyNodeFor(target)
					applyAward(activityNode, points)
				
			addScore: (target, score)->
				if hasActivities
					activityNode = findActivitiyNodeFor(target)
					points = score * activityNode.points
					applyAward(activityNode, points)
			
			getActivityScore: (target)->
				activityNode = findActivitiyNodeFor(target)
				return activityNode.score
			
			getPageScore: (page)->
				activityElementsOnPage = PureDom.querySelectorAll(page, "cd-activity")
				summedScores = activityElementsOnPage.reduce(sumActivityScore, 0)
				totalScore = summedScores / activityElementsOnPage.length
				return totalScore
			
			getModuleTotalPoints: ()->
				return moduleTotalPoints
			
			getModuleScore: ()->
				return moduleNode.score
			
			onUpdate: (callback)->
				updateCallbacks.push(callback)
		
		

# IMMUTABLE

	sumActivityScore = (sum, activityElement)->
		name = activityElement.getAttribute("name")
		activityNode = moduleNode.activities[name]
		return sum + activityNode.score
	
	
	createNodeWith = (groupName)->
		node = {}
		node.score = 0
		node[groupName] = {}
		return node
	
	
	findActivitiyNodeFor = (target)->
		switch
			when PureDom.isElement(target) then return moduleNode.activities[target.getAttribute("name")]
			when (typeof target) is "string" then return moduleNode.activities[target]
			else throw new Error("Couldn't figure out what sort of scoring target you've provided.")
		
		
			

# MUTATION
	
	loadScoringTree = ()->
		projectNode = KVStore.get(Params.project) or createNodeWith("chapters")
		chapterNode = projectNode.chapters[Params.chapter] ?= createNodeWith("modules")
		moduleNode = chapterNode.modules[Params.module] ?= createNodeWith("activities")
		
	
	crawlActivityPoints = ()->
		moduleTotalPoints = 0
		for activityElement in document.querySelectorAll("cd-activity")
			name = activityElement.getAttribute("name")
			points = parseInt(activityElement.getAttribute("points"))
			activityNode = moduleNode.activities[name] ?= {}
			activityNode.score ?= 0
			
			# Always overwrite and recompute these, because the points attribute may have changed
			activityNode.points = points
			activityNode.earnedPoints = points * activityNode.score
			
			moduleTotalPoints += points
	
	
	applyAward = (activityNode, pointsToAward)->
		return if activityNode.score >= 1
		
		pointsBefore = activityNode.earnedPoints
		
		activityNode.earnedPoints += pointsToAward
		activityNode.earnedPoints = Math.min(activityNode.earnedPoints, activityNode.points)
		
		activityNode.score = activityNode.earnedPoints / activityNode.points
		activityNode.score = Math.round(10000 * activityNode.score)/10000
		
		pointsAwarded = activityNode.earnedPoints - pointsBefore
		
		updateModuleScore()
		saveScoringTree()
		runCallbacks(pointsAwarded)
	
	
	updateModuleScore = ()->
		earnedPoints = 0
		for name, activityNode of moduleNode.activities
			earnedPoints += activityNode.score * activityNode.points
		moduleNode.score = earnedPoints / moduleTotalPoints
	
	
	saveScoringTree = ()->
		KVStore.set(Params.project, projectNode)
		console.log("Debug: saving after awarding points.")
		KVStore.save()
	
	
	runCallbacks = (pointsAwarded)->
		call(moduleNode.score, pointsAwarded) for call in updateCallbacks
		
		
# SETUP
	
	loadScoringTree()
	if hasActivities
		crawlActivityPoints()
		updateModuleScore()
		saveScoringTree()
		runCallbacks(0)
	makeAPI()
