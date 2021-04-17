extends Node2D

export (NodePath) var northRoom
export (NodePath) var southRoom
export (NodePath) var eastRoom
export (NodePath) var westRoom

var currentRoom
onready var tween = get_parent().get_parent().get_node("Tween")

func _on_Area2D_body_exited(body):	
	if body.name=="Player":					
		modulate.a = 1
		var r:NodePath
		var c:NodePath
		if northRoom:
			if body.position.y < position.y:				
				r = northRoom
				c = southRoom				
			else:
				r = southRoom
				c = northRoom				
		#TO DO - test the west/east transitions... we might need to flip the > sign
		if westRoom:
			if body.position.x > position.x:	
				r = eastRoom
				c = westRoom				
			else:
				r = westRoom
				c = eastRoom				
		#fade in new room if it's hidden
		if get_node(r).modulate.a != 1:
			tween.interpolate_property(get_node(r), "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.3, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)			
		#fade out current room, unless we're going south, in which case it's not in the way
		if !r == southRoom:
			tween.interpolate_property(get_node(c), "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.3, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
		tween.start()

