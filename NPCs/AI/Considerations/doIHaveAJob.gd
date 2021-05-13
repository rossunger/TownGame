extends Consideration

#data contains the children
export var matchIfTrue = true
func evaluate():
	score = 0
	if Game.getAncestorOfType(self, NPC).myJob:
		score = 1
	return score

func valueInArray(arr, val):
	return arr.has(val)

func valueInRange(theRange:Vector2, val):
	if val > theRange.x && val < theRange.y:
		return true
	return false
	
	
	"""
	Consideration
	- input
		- whose: mine, targets, global
	
	
	
	
	"""
