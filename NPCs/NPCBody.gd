extends KinematicBody2D
class_name NPCBody
var parent
func _ready():
	parent = get_parent()
	name = parent.name
	parent.body = self
	doRename()
	
func _physics_process(delta):	
	if not Engine.editor_hint:
		if position != parent.destination:
			#print("I'm at " + str(position) + " and I'm walking to " + str(destination) )
			if (parent.destination - position).length() < 1:
				parent.destination = position
			else:
				position += (parent.destination - position).normalized() *2
			#replace above code with pathfinding...

func doRename():	
	$NameLabel.text = name	
