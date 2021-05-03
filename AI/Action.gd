extends Node
class_name Action
var description = ""
var score = 0 #set by the consider function
var weight = 1 #weight is set by the designer... 10 = urgent, 1 = casual
export (String) var signalToEmit = "" #the signal to emit if this action is to be done.
export (Array) var signalArgs
onready var considerations = get_children()
var rng =  RandomNumberGenerator.new()
func consider():	
	rng.randomize()
	score = rng.randf_range(0, 1) #placeholder... for testing
	for consideration in considerations:
		score *= consideration.evaluate()			
		
	return score * weight
			
