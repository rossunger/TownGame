#tool
extends BaseObject
class_name NPC
export(Resource) var daysThatIWork = daysThatIWork as DaysThatIWork
onready var daysThatIWorkArr = daysThatIWork.getDaysThatIWork()

var destination: Vector2
var working = false

func _ready():	
	for child in get_children():
		if child is Brain:			
			child.connect("newAction", self, "processNewAction")	
	
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
	if location is Vector2:
		destination = location
	print("im going to location: " + str(location))

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
