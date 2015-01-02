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
				activityNode = findActivitiyNodeFor(target)
				scoreToAward = points / activityNode.points
				applyAward(activityNode, score)
				
			addScore: (target, score)->
				activityNode = findActivitiyNodeFor(target)
				applyAward(activityNode, score)
			
			getActivityScore: (id)->
				return moduleNode.activities[id].score
			
			getModulePoints: ()->
				return moduleTotalPoints
			
			getModuleScore: ()->
				return moduleNode.score
			
			onUpdate: (callback)->
				updateCallbacks.push(callback)
		
		

# PRIVATE
	
	loadScoringTree = ()->
		projectNode = KVStore.get(Params.project) or createNodeWith("chapters")
		chapterNode = projectNode.chapters[Params.chapter] ?= createNodeWith("modules")
		moduleNode = chapterNode.modules[Params.module] ?= createNodeWith("activities")
		
	
	createNodeWith = (groupName)->
		node = {}
		node.score = 0
		node[groupName] = {}
		return node


	crawlActivityPoints = ()->
		moduleTotalPoints = 0
		for activity in document.querySelectorAll("cd-activity")
			name = activity.id
			points = parseInt(activity.getAttribute("points"))
			moduleNode.activities[name] ?= {}
			moduleNode.activities[name].score ?= 0
			moduleNode.activities[name].points = points # Always overwrite
			moduleTotalPoints += points
	
	
	findActivitiyNodeFor = (target)->
		throw new Error("We can't find any cd-activity elements in the module.") unless hasActivities
		
		if PureDom.isElement(target)
			id = PureDom.querySelectorParent(target, "[id]").id
			
		else if (typeof target) is "string"
			id = target
		
		else
			throw new Error("We can't figure out what sort of scoring target you've provided.")
		
		activityNode = moduleNode.activities[id]
	
	
	applyAward = (activityNode, scoreToAward)->
		scoreBefore = activityNode.score
		
		activityNode.score ?= 0
		activityNode.score += scoreToAward
		activityNode.score = Math.round(activityNode.score * 1000)/1000 # Helps avoid rounding errors
		activityNode.score = Math.min(activityNode.score, 1)
		
		pointsAwarded = Math.floor((activityNode.score - scoreBefore) * activityNode.points)
		
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
