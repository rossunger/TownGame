extends Node2D
#export (Enums.Days) var DayOfTheWeek = Enums.Days.Monday setget SetDayOfTheWeek
#export (int, 0, 365) var DayOfTheYear = 0

var OutsideScene
var InsideScene

export(PackedScene) var StartingNeighbourhoodScene
var CurrentNeighbourhoodScene

var inside
export (PackedScene) onready var PauseMenu = PauseMenu.instance()

func _ready():				
	Game.connect("goOutside", self, "goOutside")
	Game.connect("goInside", self, "goInside")	
	Game.connect("setPaused", self, "setPaused")
	inside = get_node("Inside")	

	#init defaults - to do		
	Game.emit_signal("goOutside", {"neighbourhood": StartingNeighbourhoodScene})
	#var new_dialog = Dialogic.start('D1Q1Abby')
	#get_node("UI").add_child(new_dialog)

#func SetDayOfTheWeek(day):
	#DayOfTheWeek = day	

func setPaused(paused):
	print("root got paused")
	if paused:
		$UI.add_child(PauseMenu)
	else:
		$UI.remove_child(PauseMenu)
	
func goInside(data = {}):		
	if !data.insideHouse:
		print("ERROR")
	Game.lastStreet = Game.CurrentStreetOrRoom.name	
	#remove_child the neighbourhood, add_child the inside scene
	$Outside.remove_child(Game.CurrentNeighbourhood)	
	$Inside.add_child(Game.InsideHouses[data.insideHouse])							
	

#data can include: neighbourhood, street
func goOutside(data = {}):		
	#1. if different neighbourhood...
	if data.has("neighbourhood") && data.neighbourhood != CurrentNeighbourhoodScene:
		#...then clear everything from memory
		for child in $Outside.get_children():
			child.queue_free()
		for child in $Inside.get_children():
			child.queue_free()		
		Game.InsideHouses.clear()
		#and load the new neighbourhood...
		Game.CurrentNeighbourhood = data.neighbourhood.instance()
		$Outside.add_child(Game.CurrentNeighbourhood)
		Game.emit_signal("newPlayerStart", Game.CurrentNeighbourhood.get_node("PlayerStart").global_position)
		#...including the inside scenes
		for street in Game.CurrentNeighbourhood.get_children():
			if street is Street:
				for house in street.get_children():
					#check if it's a house, and if it's "InsideScene" parameter has been set
					if house is OutsideHouse && house.InsideScene is PackedScene:
						var i = house.InsideScene.instance()				
						Game.InsideHouses[house.InsideScene.get_path()] = i						
												
	#2. if same neighbourhood, 
	# .... if we were inside, then remove_child on all the inside scenes, and add_child the neighbourhood to outside
	elif $Inside.get_child_count() > 0:
		for child in $Inside.get_children():
			$Inside.remove_child(child)
		$Outside.add_child(Game.CurrentNeighbourhood)
	if data.has("street"):
		print("we got a street:" + str(data.street))
		Game.CurrentNeighbourhood.LoadStreet(Game.CurrentNeighbourhood.get_node(data.street))
	elif Game.lastStreet:
		Game.CurrentNeighbourhood.LoadStreet(Game.CurrentNeighbourhood.get_node(Game.lastStreet))
	else:
		print("ERROR loading Street... don't know what street to load :/")
	#Game.lastStreet = null		
	
func emit_goOutside(params):
	Game.emit_signal("goOutside", params)
func emit_goInside(params):
	Game.emit_signal("goInside", params)	
