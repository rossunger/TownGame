extends Node
class_name Consideration
export var description = ""	
var score = 0 #set by the evaluate functio
var weight = 1 #weight is set by the designer... 10 = urgent, 1 = casual	
#var Curve = Curve.new()
var conditions =  []
func evaluate():
	for condition in conditions:
		condition.check()
