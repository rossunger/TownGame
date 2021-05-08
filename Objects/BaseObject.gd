extends Node2D
class_name BaseObject

var body: BaseBody
var bodyNeighbourhood setget changeNeighbourhood #the PackedScene of the neighbourhood that the body is in
var bodyStreetOrRoom setget changeStreetOrRoom #the name of the street that the body is on, inside of the neighbourhood.
var bodyInside setget changeInside #the path to the PackedScene of the insideHouse the body is inside of
var bodyGlobalPosition #the global x,y coords of the body

func changeNeighbourhood(value):
	bodyNeighbourhood = value
	processSceneChange({"neighbourhood": value})
		
func changeStreetOrRoom(value):
	bodyStreetOrRoom = value
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
	if data.has("insideHouse"):
		if data.insideHouse == bodyInside:
			inside = true			
	if data.has("street"):
		if bodyStreetOrRoom == data.street:
			street = true
	
	if not has_node(name):		
		leaveScene()	
	else:
		bodyGlobalPosition = body.global_position
	if neighbourhood == true || street == true:		
		returnToScene()	
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
Every time we load a neighbourhood, or an inside scene:
	- call get_tree().call_group("ObjectsInScene", "leaveScene") 
	- we check which objects are supposed to be in the new scene, and call returnToScene() on each of them




"""
