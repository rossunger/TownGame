extends KinematicBody2D
class_name BaseBody

var parent
func _ready():
	parent = get_parent()
	name = parent.name
	parent.body = self	
