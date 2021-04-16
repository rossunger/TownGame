extends Node2D

export (NodePath) var firstRoom
var currentZ
func _ready():
	currentZ = get_node(firstRoom).z
	#Hide all the rooms that aren't visible
	for room in $Rooms.get_children():							
		if room.z > currentZ:
			room.modulate.a = 0
		else:
			room.modulate.a = 1

	


func _on_Area2D_body_entered(body):
	if body.name=="Player":		
		get_node("/root/Game").goOutside(get_node("/root/Game").lastStreet)

func show():	
	get_node("Floor/FloorCollision").set_deferred("disabled", false)
	visible = true;	
func hide():	
	get_node("Floor/FloorCollision").set_deferred("disabled", true)
	visible = false;	
