extends Node

signal goInside #for when player goes into a house
signal goOutside #for when player changes Neighbourhoods
signal rideVehicle
signal playerMoved #for parallax effect of streets
signal newPlayerStart
signal doInteraction 
signal setPaused
signal setTimeOfDay
signal setDayOfTheYear
signal SaveGame
signal LoadGame

var world
var outside
var inside

var NPCManager: Node2D
var ObjectManager : Node2D
var player : Player
var timeOfDay = Enums.TimesOfDay.Morning
var dayOfTheYear = 291
var lastStreet #the nodepath to the last street we were on, relative to the neighbourhood
var InsideHouses: Dictionary = {}

var interactables = []

onready var tween = Tween.new()

var isPaused = false
export(PackedScene) var PauseMenuScene 

func _ready():
	world = get_node("/root/GameRoot/World")
	world.add_child(tween)	
	player = get_node("/root/GameRoot/Player")
	tween.connect("tween_all_completed", player, "tweenDone")
	outside = world.get_node("Outside")
	inside = world.get_node("Inside")

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

#####################
# UTILITY FUNCTIONS #
#####################
func getHouse(houseName):
	return inside.get_node(houseName)

func getRoom(houseName, roomName):	
	return inside.get_node(houseName + "/Rooms/" + roomName)

func getNeighbourhood(neighbourhoodName):
	return outside.get_node(neighbourhoodName)

func getStreet(neighbourhoodName, streetName):
	return outside.get_node(neighbourhoodName + "/" + streetName)

func changeStreetOrRoom(data={}):
	if data.has("street"):
		getNeighbourhood(player.bodyNeighbourhood).LoadStreet(data.street)
	
func goInside(houseName, roomName):	
	inside.visible = true
	getHouse(houseName).visible = true	
	outside.visible = false
	
	
func goOutside(neighbourhoodName, streetName):
	getHouse(player.bodyHouse).visible = false	
	inside.visible = false
	outside.visible = true
