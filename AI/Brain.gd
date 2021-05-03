extends Node
class_name Brain

signal stopAndWait
signal goToWork
signal talkToTarget

onready var actions = get_children()
var currentAction

func _ready():
	add_to_group("AI")
	connect("stopAndWait", get_parent(), "stopAndWait") #debug stuff
	if !actions[0].signalToEmit:
		actions[0].signalToEmit = "stopAndWait" #debug stuff		
	
func ai_tick():	
	var winner = decide(actions)	
	if currentAction != winner:
		currentAction = winner
		print("new winner: " + winner.name)
		emit_signal(winner.signalToEmit, winner.signalArgs)	

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
