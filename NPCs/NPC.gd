tool
extends Node2D
export var tint = Color(1,1,1,1) setget set_tint; #for debug purposes
export var characterName = "CharacterName" setget set_name;
#export var timelines = ["timeline1"];
#export var currentTimeline = 0;

export var Beliefs : Array #of bool? or float?
export var Memories : Array #of bool? or of "events"?
export var Households : Array #of type NodePath

func set(param, value):
	print("setting: " + param)
	

func set_emotion(emotion:String, value:float, relative=true):
	if relative:
		get_node("MyEmotions")[emotion] += value
	else:
		get_node("MyEmotions")[emotion] = value	
	get_node("EmotionLabel").text = get_node("MyEmotions").getLargestEmotionName()

func set_tint(value):
	tint = value;
	modulate = value;	

func set_name(value):
	characterName = value;
	name = characterName;
	if has_node("RichTextLabel"):
		var label = get_node("RichTextLabel")
		if (label):			
			label.bbcode_text = "[wave amp=20 freq=4]" + characterName +"[/wave]";
			label.text = characterName

func _ready():
	set_tint(tint);
	set_name(characterName);	
	$MyRelationships.newRelationship(name)
		
#experiment! this gets called when the players "nearby" area collides with this NPC
func playNextTimeline():
#	if currentTimeline < timelines.size():	
		#var d = Dialogic.start(timelines[currentTimeline])
		#get_tree().get_root().get_node("Game/Character/CanvasLayer").add_child(d);
		#currentTimeline+=1
	pass
	
func stopAndWait():
	print("im stopping and waiting")
	#play idle animation
	#target location = null

func goToLocation(location):
	print("im going to location: " + location)


""" List of INSTRUCTIONS an ACTION can give a CHARACTER
Wait
Walk somewhere
Talk to someone
Change Parameter [emotional state, belief, wealth, etc)
Interact with object (call a function on that object)

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
