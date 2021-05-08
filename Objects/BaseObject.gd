extends Node2D
class_name BaseObject

var body: BaseBody
var bodyNeighbourhood #the neighbourhood that the body is in
var bodyStreet #the street that the body is on
var bodyInside #the house the body is inside of
var bodyGlobalPosition #the global x,y coords of the body

func _ready():
	Game.connect("goOutside", self, "processSceneChange")		
#	add_to_group("ObjectsInScene")	
	pass
	
func processSceneChange(data):
	if data.has("neighbourhood"):
		if data.neighbourhood == bodyNeighbourhood:
			returnToScene()
		elif not has_node(name):
			leaveScene()
	if data.has("insideHouse"):
		if data.insideHouse == bodyNeighbourhood:
			returnToScene()
		elif not has_node(name):
			leaveScene()
			
func leaveScene():
	#bodyParent = 
	print(name + " is leaving the scene")
	body.get_parent().remove_child(body)
	add_child(body)	
	body.set_process(false)
	

func returnToScene():
	print(name + " is returning to the scene")
	#this happens when we load a new neighbourhood, or a new inside scene...
	body.set_process(true)
	remove_child(body)
	var st = Game.CurrentStreetOrRoom
	st.add_child(body)		
	body.global_position = bodyGlobalPosition

func teleport(newNeighbourhood, globalPosition = Vector2(0,0), newStreet = null, newInside = null):
	if newNeighbourhood:
		bodyNeighbourhood = newNeighbourhood		
	if newStreet:
		bodyStreet = newStreet
	if newInside:
		bodyInside = newInside
	if globalPosition:
		print(body.global_position)
		bodyGlobalPosition = globalPosition
	if load(Game.CurrentNeighbourhood.filename) == newNeighbourhood:
		returnToScene()		


"""
Every time we load a neighbourhood, or an inside scene:
	- call get_tree().call_group("ObjectsInScene", "leaveScene") 
	- we check which objects are supposed to be in the new scene, and call returnToScene() on each of them




"""
