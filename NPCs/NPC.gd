#tool
extends BaseObject
class_name NPC
var myJobs = []

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

func newJob(jobPath):
	var job =  Game.businessManager.get_node(jobPath)	
	if not myJobs.has(job):
		myJobs.append(job)

func _physics_process(delta):
	if destination != body.global_position:
		if body.get_node("Audio/Footsteps").playing ==false:
			body.get_node("Audio/Footsteps").play()
	else:
		if body.get_node("Audio/Footsteps").playing == true:
			body.get_node("Audio/Footsteps").stop()

func speakPhrase(phrase):
	var talk = body.get_node("Audio/Talk")
	if talk is AudioStreamPlayer2D:
		talk.stream = load("res://Audio/Dialog/" + phrase + ".ogg")
		talk.play(0)

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
