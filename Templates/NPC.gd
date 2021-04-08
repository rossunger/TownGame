tool
extends Node2D
export var tint = Color(1,1,1,1) setget set_tint; #for debug purposes
export var characterName = "Character Name" setget set_name;
#export var timelines = ["timeline1"];
#export var currentTimeline = 0;
#export (int, FLAGS, "Safe", "Flag2", "Nope") var testtt
#export var CharacterData : Dictionary setget set_characterData #Use dictionary to set Character???
#func set_characterData(value):
#	CharacterData = {"Name": Character.Name, "Emotions": Character.Emotions}

export var Relationships = []
export var Emotions = {"happiness": 0, "sadness":0, "anger": 0, "surprise": 0, "disgust": 0, "fear":0}
export var Beliefs : Array #of bool? or float?
export var Behaviors : Array #of behaviors?
export var Memories : Array #of bool? or of "events"?
export var Households : Array #of type NodePath

func set_emotion(emotion:String, value:float, relative=true):
	if relative:
		Emotions[emotion] += value
	else:
		Emotions[emotion] = value	
	get_node("Emotion").text = test.largestKeyDictionary(Emotions)

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
		
#experiment! this gets called when the players "nearby" area collides with this NPC
func playNextTimeline():
#	if currentTimeline < timelines.size():	
		#var d = Dialogic.start(timelines[currentTimeline])
		#get_tree().get_root().get_node("Game/Character/CanvasLayer").add_child(d);
		#currentTimeline+=1
	pass
	
