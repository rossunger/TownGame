tool
extends Sprite

export var tint = Color(1,1,1,1) setget set_tint;
export var characterName = "Character Name" setget set_name;
export var timelines = ["timeline1"];
export var currentTimeline = 0;

func set_tint(value):
	tint = value;
	modulate = value;	
func set_name(value):
	characterName = value;
	name = characterName;
	var label = get_node("RichTextLabel")
	if (label):
		label.bbcode_text = "[wave amp=20 freq=4]" + characterName +"[/wave]";
		
func _ready():
	set_tint(tint);
	set_name(characterName);
		
func playNextTimeline():
	if currentTimeline < timelines.size():	
		var d = Dialogic.start(timelines[currentTimeline])
		get_tree().get_root().get_node("Game/Character/CanvasLayer").add_child(d);
		currentTimeline+=1
		
	
