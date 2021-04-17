extends Area2D

export (NodePath) var northSt
export (NodePath) var southSt

func _on_Area2D_body_exited(body):	
	if body.name=="Player":					
		if northSt:			
			#get_node("/root/Game/Outside").CurrentStreet = ""			
			if body.position.y < position.y:					
				get_node("/root/Game/Outside").CurrentStreet = get_node(northSt).get_path()
			else:
				get_node("/root/Game/Outside").CurrentStreet = get_node(southSt).get_path()
		print(get_node("/root/Game/Outside").CurrentStreet)						
