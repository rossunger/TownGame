extends Node
class_name Brain

signal newAction

onready var actions = get_children()
var currentAction

func _ready():
	add_to_group("AI")	
	
func ai_tick():	
	var winner = decide(actions)	
	if currentAction != winner:
		currentAction = winner		
		emit_signal("newAction", [winner.signalToEmit, winner.signalArgs])	

func LoadBrain():
	pass
	#actions = loadFromFile

func decide(actions = []):
	var leadingAction
	var leadingActionScore = 0		
	for action in actions:
		if action is Action:
			var actionScore = action.consider()
			if actionScore > leadingActionScore:
				leadingAction = action
				leadingActionScore = actionScore
	return leadingAction		
