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
			
			getActivityScore: (id)->
				return moduleNode.activities[id].score
			
			getPageScore: (page)->
				return PureDom.querySelectorAll(page, "cd-activity").reduce(sumActivityScore, 0)

			getModuleTotalPoints: ()->
				return moduleTotalPoints
			
			getModuleScore: ()->
				return moduleNode.score
			
			onUpdate: (callback)->
				updateCallbacks.push(callback)
		
		

# IMMUTABLE

	sumActivityScore = (sum, activity)->
		id = getNearestId(activity)
		activity = moduleNode.activities[id]
		return sum + activity.score


	createNodeWith = (groupName)->
		node = {}
		node.score = 0
		node[groupName] = {}
		return node
	
	
	getNearestId = (element)->
		return PureDom.querySelectorParent(element, "[id]").id
	
	
	findActivitiyNodeFor = (target)->
		if PureDom.isElement(target)
			id = PureDom.querySelectorParent(target, "[id]").id
		else if (typeof target) is "string"
			id = target
		else
			throw new Error("Couldn't figure out what sort of scoring target you've provided.")
		
		return moduleNode.activities[id]
			

# MUTATION
	
	loadScoringTree = ()->
		projectNode = KVStore.get(Params.project) or createNodeWith("chapters")
		chapterNode = projectNode.chapters[Params.chapter] ?= createNodeWith("modules")
		moduleNode = chapterNode.modules[Params.module] ?= createNodeWith("activities")
		
	
	crawlActivityPoints = ()->
		moduleTotalPoints = 0
		for activityElement in document.querySelectorAll("cd-activity")
			id = getNearestId(activityElement)
			points = parseInt(activityElement.getAttribute("points"))
			activityNode = moduleNode.activities[id] ?= {}
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
		for id, activityNode of moduleNode.activities
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
