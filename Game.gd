extends Node
signal goInside
signal goOutside
signal playerMoved
signal newPlayerStart
signal doInteraction

var player

func setPlayerTargetAction(action):
	player.targetAction = action

func doInteraction():	
	for i in get_tree().get_nodes_in_group("interactable"):
		i.interact()
	#1. decide which one has priority
	#2. 
	
