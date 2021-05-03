tool
extends Node2D

func _ready():	
	if !Engine.is_editor_hint():
		queue_free()
	
func clearChildren():
	for child in get_children():
		remove_child(child)
