extends Node
class_name Action
var description = ""
var score = 1 #set by the consider function
export (int, 1, 10) var weight = 1 #weight is set by the designer... 10 = urgent, 1 = casual
export (String) var signalToEmit = "" #the signal to emit if this action is to be done.
export (Array) var signalArgs
onready var considerations = get_children()
func consider():		
	score = 1
	for consideration in considerations:
		score *= consideration.evaluate()			
		
	return score * weight
			
