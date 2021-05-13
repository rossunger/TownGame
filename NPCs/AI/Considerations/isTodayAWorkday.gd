extends Consideration

#data contains the children
export var matchIfTrue = true

func evaluate():
	score = 0
	for job in Game.getAncestorOfType(self, NPC).myJobs:
		if job.daysToWork.has(Enums.getDayOfTheWeek(Game.dayOfTheYear)) == matchIfTrue:
			score = 1	
	return score

func valueInArray(arr, val):
	return arr.has(val)

func valueInRange(theRange:Vector2, val):
	if val > theRange.x && val < theRange.y:
		return true
	return false
