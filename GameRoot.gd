tool
extends Node2D
#export (Enums.Days) var DayOfTheWeek = Enums.Days.Monday setget SetDayOfTheWeek
#export (int, 0, 365) var DayOfTheYear = 0
onready var NPCManager = get_node("NPCManager")

export(PackedScene) var OutsideScene
export(PackedScene) var InsideScene

export(PackedScene) var StartingNeighbourhoodScene
var CurrentNeighbourhoodScene
var CurrentNeighbourhood
var InsideHouses: Dictionary = {}

var inside
var lastStreet

func _ready():				
	Game.connect("goOutside", self, "goOutside")
	Game.connect("goInside", self, "goInside")	
	inside = get_node("Inside")
	#init defaults - to do		
	Game.player = $Player
	Game.emit_signal("goOutside", {"neighbourhood": StartingNeighbourhoodScene})
	#var new_dialog = Dialogic.start('D1Q1Abby')
	#get_node("UI").add_child(new_dialog)

#func SetDayOfTheWeek(day):
	#DayOfTheWeek = day	
	
func goInside(data = {}):		
	if !data.insideHouse:
		print("ERROR")
	#remove_child the neighbourhood, add_child the inside scene
	$Outside.remove_child(CurrentNeighbourhood)	
	$Inside.add_child(InsideHouses[data.insideHouse])			
	
	#to do: set LastStreet
	#lastStreet = .currentStreet									

func goOutside(data = {}):	
	if !data.has("neighbourhood"):
		data.neighbourhood = CurrentNeighbourhoodScene
	#1. if different neighbourhood...
	if data.neighbourhood != CurrentNeighbourhoodScene:
		#...then clear everything from memory
		for child in $Outside.get_children():
			child.queue_free()
		for child in $Inside.get_children():
			child.queue_free()		
		InsideHouses.clear()
		#and load the new neighbourhood...
		CurrentNeighbourhood = data.neighbourhood.instance()
		$Outside.add_child(CurrentNeighbourhood)
		Game.emit_signal("newPlayerStart", CurrentNeighbourhood.get_node("PlayerStart").position)
		#...including the inside scenes
		for street in CurrentNeighbourhood.get_children():
			if street is Street:
				for house in street.get_children():
					#check if it's a house, and if it's "InsideScene" parameter has been set
					if house is OutsideHouse && house.InsideScene is PackedScene:
						var i = house.InsideScene.instance()				
						InsideHouses[house.InsideScene.get_path()] = i						
						print(InsideHouses.keys()[0])
	#2. if same neighbourhood, remove_child on all the inside scenes, and add_child the neighbourhood to outside
	else:
		for child in $Inside.get_children():
			$Inside.remove_child(child)
		$Outside.add_child(CurrentNeighbourhood)	
	lastStreet = ""		

