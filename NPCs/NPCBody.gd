extends BaseBody
class_name NPCBody

func _ready():
	doRename()

func doRename():	
	$NameLabel.text = name	
	
func _physics_process(delta):	
	if not Engine.editor_hint:
		if position != parent.destination:
			#print("I'm at " + str(position) + " and I'm walking to " + str(destination) )
			if (parent.destination - position).length() < 1:
				parent.destination = position
			else:
				position += (parent.destination - position).normalized() *2
			#replace above code with pathfinding...	
