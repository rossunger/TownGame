tool
extends Node
class_name NPC
export(Resource) var daysThatIWork = daysThatIWork as DaysThatIWork
onready var daysThatIWorkArr = daysThatIWork.getDaysThatIWork()

var destination: Vector2
var working = false
var body
var bodyNeighbourhood #the neighbourhood that the body is in
var bodyStreet #the street that the body is on
var bodyInside #the house the body is inside of

func _ready():	
	for child in get_children():
		if child is Brain:			
			child.connect("newAction", self, "processNewAction")
	Game.connect("goOutside", self, "processSceneChange")

func processNewAction(data = []):	
	print("processing new action")
	if data[0] == "wait":
		stopAndWait()
	if data[0] == "goToWork":
		goToLocation("WORK")

func set(param, value):
	print("setting: " + param)

func _on_CharacterName_tree_entered():
	if Engine.editor_hint:
		$NPCBody.doRename()			
	
func set_emotion(emotion:String, value:float, relative=true):
	if relative:
		get_node("MyEmotions")[emotion] += value
	else:
		get_node("MyEmotions")[emotion] = value	
	get_node("EmotionLabel").text = get_node("MyEmotions").getLargestEmotionName()

#Insert AI functions here??	
func stopAndWait():
	print("im stopping and waiting")
	#play idle animation
	#target location = null

func goToLocation(location):
	print("im going to location: " + location)

func _get_configuration_warning():
	var warning:= PoolStringArray()
	var hasBrain = false
	#var hasBrain = false
	for child in get_children():		
		if child is Brain:
			hasBrain=true
	if !hasBrain:
		warning.append("%s is missing a Brain" % name)
	return warning.join("/n")

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
	print(body.get_parent().get_path())
	body.get_parent().remove_child(body)
	add_child(body)	
	body.set_process(false)
	

func returnToScene():
	#this happens when we load a new neighbourhood, or a new inside scene...
	body.set_process(true)
	remove_child(body)
	var st = Game.CurrentNeighbourhood.get_node(bodyStreet)
	st.add_child(body)		

func teleport(newNeighbourhood, newStreet = null, newInside = null):
	if newNeighbourhood:
		bodyNeighbourhood = newNeighbourhood		
	if newStreet:
		bodyStreet = newStreet
	if newInside:
		bodyInside = newInside
	if load(Game.CurrentNeighbourhood.filename) == newNeighbourhood:
		returnToScene()		

""" List of INSTRUCTIONS an ACTION can give a CHARACTER
Wait
Walk somewhere
Talk to someone
Interact with object (call a function on that object)
Change Parameter [emotional state, belief, wealth, etc)


SEQUENCES (complex actions)
Deliver object to person
- walk to object
- change Parameter (pick up object)
- walk to person
- change parameter (give object to person)


List of STATES a CHARACTER can be in
- waiting
- walking
- talking
- interacting (with object)
- thinking? (is this the same as waiting?)




Feel / Change an Emotion
Go somewhere
Go to work / do work
Help someone 
Do recreational activity - Play with person/object/imagination, watch TV
Create something
Destroy something
Contemplate / Think about something
Meditate / Feel into yourself
Buy/Sell something



"""
