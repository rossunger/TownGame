extends Node
signal goInside
signal goOutside
signal rideVehicle
signal playerMoved
signal newPlayerStart
signal doInteraction
signal setPaused
signal setTimeOfDay
signal setDayOfTheYear
signal SaveGame
signal LoadGame

var NPCManager: Node2D
var ObjectManager : Node2D
var player : Player
var timeOfDay = Enums.TimesOfDay.Morning
var dayOfTheYear = 291
var CurrentNeighbourhood #the instance of the scene
var CurrentStreetOrRoom #the instance of the room or scene
var lastStreet #the nodepath to the last street we were on, relative to the neighbourhood
var InsideHouses: Dictionary = {}

var interactables = []

var isPaused = false
export(PackedScene) var PauseMenuScene 

func setPaused(paused=true):	
	isPaused = paused
	emit_signal("setPaused", paused)	

func setPlayerTargetAction(action):
	player.targetAction = action

func addInteractable(item):
	if !interactables.has(item):
		interactables.append(item)
	interactables.sort_custom(self, "sortInteractablesByPriority")
	for i in interactables:
		i.get_node("InteractionHint").visible = false	
	if not player.currentVehicle:
		interactables[0].get_node("InteractionHint").visible = true	
	
func removeInteractable(item):
	if interactables.has(item):
		item.get_node("InteractionHint").visible = false
		interactables.erase(item)
		if interactables.size()>0 && not player.currentVehicle:
			interactables[0].get_node("InteractionHint").visible = true
	
func doInteraction():		
	if interactables.size() > 0:		
		interactables[0].interact()

func sortInteractablesByPriority(a, b):
	if a.get_parent() is Player && not b.get_parent() is Player:
		return true
	elif a is Vehicle && not b is Vehicle:
		return true
	elif abs((a.global_position - player.global_position).length()) < abs((b.global_position - player.global_position).length()):
		return true
	return false

	
	#1. decide which one has priority
	#	- vehicles first
	#	- then items you're holding?
	#	- then 
	#2. interact it	
