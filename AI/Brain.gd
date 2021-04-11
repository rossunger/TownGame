extends Node
class_name Brain
onready var actions = get_children()
var currentAction
func _ready():
	add_to_group("AI")
	connect("stopAndWait", get_parent(), "stopAndWait") #debug stuff
	actions[0].signalToEmit = "stopAndWait" #debug stuff		
	
func ai_tick():	
	var winner = decide(actions)
	if currentAction != winner:
		currentAction = winner
		emit_signal(winner.signalToEmit)	

func LoadBrain():
	pass
	#actions = loadFromFile

func decide(actions = []):
	pass

signal stopAndWait
