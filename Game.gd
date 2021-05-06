extends Node
signal goInside
signal goOutside
signal rideBike
signal playerMoved
signal newPlayerStart
signal doInteraction
signal setPaused
signal setTimeOfDay
signal setDayOfTheYear
signal SaveGame
signal LoadGame

var NPCManager: Node2D
var player
var timeOfDay = Enums.TimesOfDay.Morning
var dayOfTheYear = 291
var CurrentNeighbourhood

var isPaused = false
export(PackedScene) var PauseMenuScene 

func setPaused(paused=true):	
	isPaused = paused
	emit_signal("setPaused", paused)	

func setPlayerPosition(newPosition):
	pass
	#player.position = newPosition

func setPlayerTargetAction(action):
	player.targetAction = action

func doInteraction():	
	for i in get_tree().get_nodes_in_group("interactable"):
		i.interact()
	#1. decide which one has priority
	#2. 
	
