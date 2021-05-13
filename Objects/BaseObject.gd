extends Node2D
class_name BaseObject

var body: BaseBody
var bodyNeighbourhood = "" #the name of the neighbourhood that the body is in
var bodyHouse = "" #the name of the house that the body is in
var bodyStreet = ""  #the name of the street that the body is on, inside of the neighbourhood.
var bodyRoom = "" #the name of the room that the body is on, inside of the house.
var bodyGlobalPosition #the global x,y coords of the body

var currentVehicle = null
export (int) var speed = Enums.PlayerSpeed.Walking
var velocity: Vector2
var navPath
var destination: Vector2
var navEnabled = true

func _ready():
	bodyNeighbourhood = "Downtown"
	bodyStreet = "MainSt"
	destination = global_position

func _physics_process(delta):
	if not Engine.editor_hint:		
		if currentVehicle:		
			currentVehicle.doMovement(velocity)				
		if navEnabled:
			doNavigation(delta)		

func doNavigation(delta):
	if body && body.global_position != destination:		
		if navPath && navPath.size() > 0:
			# Calculate the movement distance for this frame
			var distance_to_walk = speed * delta			
			var targetPosition = body.global_position
			# Move the player along the path until he has run out of movement or the path ends.
			while distance_to_walk > 0 and navPath.size() > 0:
				var distance_to_next_point = body.global_position.distance_to(navPath[0])
				if distance_to_walk <= distance_to_next_point:
					# The player does not have enough movement left to get to the next point.
					targetPosition += body.global_position.direction_to(navPath[0]) * distance_to_walk 
					break
				else:
					# The player get to the next point
					targetPosition = navPath[0]
					navPath.remove(0)
					# Update the distance to walk
					distance_to_walk -= distance_to_next_point
			velocity = body.global_position.direction_to(targetPosition) * speed 
			velocity = body.move_and_slide(velocity);
			#body.position += velocity/10
			if body.parent.name == "Abby":
				print(body.global_position)
			if abs( (body.global_position- destination).length()) < 2:				
				body.global_position = destination
			else:				
				goToLocation(destination)


func enterVehicle(vehicle):
	if vehicle && not currentVehicle:
		vehicle.set_collision_layer_bit(Enums.Layers.OutsideSolid, false)
		vehicle.set_collision_mask_bit(Enums.Layers.OutsideSolid, false)	
		
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
	if currentVehicle:
		currentVehicle.set_collision_layer_bit(Enums.Layers.OutsideSolid, true)
		currentVehicle.set_collision_mask_bit(Enums.Layers.OutsideSolid, true)			
		currentVehicle.exitVehicle()
		currentVehicle = null

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
	destination = globalPosition
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
	destination = globalPosition
	

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

func goToLocation(newDestination):
	if newDestination is Vector2:
		destination = newDestination
		navPath = Game.pathfindingOutside.get_new_path(body.global_position, destination) 		
		navPath.remove(0)
			
	#print("im going to location: " + str(newDestination))

