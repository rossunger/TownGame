extends Node
class_name Action
var description = ""
var score = 0 #set by the consider function
var weight = 1 #weight is set by the designer... 10 = urgent, 1 = casual
export (String) var signalToEmit = "" #the signal to emit if this action is to be done.
var considerations = []	
func consider():				
	for consideration in considerations:
		consideration.evaluate()
			
