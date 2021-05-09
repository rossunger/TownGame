extends Node2D
class_name BaseObject

var body: BaseBody
var bodyNeighbourhood = "" #the name of the neighbourhood that the body is in
var bodyHouse = "" #the name of the house that the body is in
var bodyStreet = ""  #the name of the street that the body is on, inside of the neighbourhood.
var bodyRoom = "" #the name of the room that the body is on, inside of the house.
var bodyGlobalPosition #the global x,y coords of the body

var currentVehicle = null
export (int) var speed = 300
var velocity: Vector2

func _ready():
	bodyNeighbourhood = "Downtown"
	bodyStreet = "MainSt"

func _physics_process(delta):
	velocity = body.move_and_slide(velocity);
	if currentVehicle:		
		currentVehicle.doMovement(velocity)

func enterVehicle(vehicle):
	if vehicle && not currentVehicle:
		body.set_collision_layer_bit(Enums.Layers.OutsideSolid, false)
		body.set_collision_mask_bit(Enums.Layers.OutsideSolid, false)	
		
		vehicle.get_parent().remove_child(vehicle)
		body.add_child(vehicle)		
		vehicle.position = Vector2(0,0)
		if vehicle.vehicleType == Enums.VehicleType.Bike:
			speed = Enums.PlayerSpeed.Biking
		if vehicle.vehicleType == Enums.VehicleType.Car:
			speed = Enums.PlayerSpeed.Car
		currentVehicle = vehicle

func exitVehicle():
	speed = Enums.PlayerSpeed.Walking			
	currentVehicle.exitVehicle()
	currentVehicle = null
	body.set_collision_layer_bit(Enums.Layers.OutsideSolid, true)
	body.set_collision_mask_bit(Enums.Layers.OutsideSolid, true)

func teleportInside(houseName, roomName, globalPosition):
	bodyNeighbourhood = ""
	bodyStreet = ""
	body.set_collision_layer_bit(Enums.Layers.InsideSolid, true)
	body.set_collision_layer_bit(Enums.Layers.OutsideSolid, false)
	body.set_collision_mask_bit(Enums.Layers.InsideSolid, true)
	body.set_collision_mask_bit(Enums.Layers.OutsideSolid, false)
	if bodyRoom != roomName || bodyHouse != houseName:		
		bodyHouse = houseName
		bodyRoom = roomName
		body.get_parent().remove_child(body)
		Game.getRoom(bodyHouse, bodyRoom).add_child(body)
	body.global_position = globalPosition
	print(global_position)
	
	
func teleportOutside(neighbourhoodName, streetName, globalPosition ):	
	body.set_collision_layer_bit(Enums.Layers.InsideSolid, false)
	body.set_collision_layer_bit(Enums.Layers.OutsideSolid, true)
	body.set_collision_mask_bit(Enums.Layers.InsideSolid, false)
	body.set_collision_mask_bit(Enums.Layers.OutsideSolid, true)
	if bodyNeighbourhood != neighbourhoodName ||	bodyStreet != streetName || body.get_parent() == self: 
		bodyNeighbourhood = neighbourhoodName
		bodyStreet = streetName
		body.get_parent().remove_child(body)
		Game.getStreet(bodyNeighbourhood, bodyStreet).add_child(body)
	bodyHouse = ""
	bodyRoom = ""
	body.global_position = globalPosition
	

func setStreet(streetName):	
	var pos = body.global_position
	body.get_parent().remove_child(body)
	Game.getStreet(bodyNeighbourhood, streetName).add_child(body)
	bodyStreet = streetName
	body.global_position = pos
	

func setRoom(roomName):
	var pos = body.global_position		
	body.get_parent().remove_child(body)	
	Game.getRoom(bodyHouse, roomName).add_child(body)
	bodyRoom = roomName
	body.global_position = pos	

"""

func changeNeighbourhood(value):
	bodyNeighbourhood = value
	processSceneChange({"neighbourhood": value})
		
func changeStreetOrRoom(value):
	#bodyStreetOrRoom = value
	processSceneChange({"street": value})
	
func changeInside(value):
	bodyInside = value
	processSceneChange({"insideHouse": value})
	
func _ready():
	Game.connect("goOutside", self, "processSceneChange")			
	
func processSceneChange(data):
	var neighbourhood = null
	var inside = null
	var street = null
	if not bodyNeighbourhood:
		bodyNeighbourhood = load(Game.CurrentNeighbourhood.filename)
	if not bodyStreetOrRoom:
		bodyStreetOrRoom = Game.CurrentStreetOrRoom.name
	if body.get("player"):
		print("processing scene change on player")
	if data.has("neighbourhood"):
		#if we're going to the neighbourhood in which this object currently is, then return
		if data.neighbourhood == bodyNeighbourhood:
			neighbourhood = true	
		else:
			neighbourhood = false
	if data.has("insideHouse"):
		if data.insideHouse == bodyInside:
			inside = true
		else:
			inside = false
	if data.has("street"):
		if bodyStreetOrRoom == data.street:
			street = true
	
	# possibilities:
	# - in the scene, stays in the scene   :   
	#	 - if inside:  sameNeighbourhood, and same insideHouse
	#	- if outside:  sameNeighbourhood
	# - in the scene, leaves the scene
	#	- if inside:   body has inside, and 
	#	- if outside:
	# - out of scene, enters scene
	# - out of scene, stays out of scene
	if neighbourhood == true || street == true:
		bodyGlobalPosition = body.global_position
		returnToScene()
	elif not has_node(name):		
		leaveScene()	
	#if this body isn't already out of the scene, then return it to the original parent
	
	
			
			
func leaveScene():	
	print(name + " is leaving the scene")
	bodyGlobalPosition = body.global_position
	body.get_parent().remove_child(body)
	add_child(body)	
	body.set_process(false)
	

func returnToScene():	
	print(name + " is returning to the scene")
	#this happens when we load a new neighbourhood, or a new inside scene...
	body.set_process(true)
	body.get_parent().remove_child(body)
	Game.CurrentNeighbourhood.get_node(bodyStreetOrRoom).add_child(body)
	if bodyGlobalPosition:
		body.global_position = bodyGlobalPosition 

func teleport(newNeighbourhood, globalPosition = Vector2(0,0), newStreet = null, newInside = null):
	if newNeighbourhood:
		bodyNeighbourhood = newNeighbourhood		
	if newStreet:
		bodyStreetOrRoom = newStreet
	if newInside:
		bodyInside = newInside
	if globalPosition:
		print(body.global_position)
		bodyGlobalPosition = globalPosition	
"""
