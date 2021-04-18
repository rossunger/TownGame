tool
extends Area2D

export (NodePath) var northSt
export (NodePath) var southSt

func _on_Area2D_body_exited(body):		
	if body is Player:					
		if northSt:						
			if body.position.y < position.y:					
				get_node("../..").LoadStreet(get_node(northSt))
			else:
				get_node("../..").LoadStreet(get_node(southSt))

func _get_configuration_warning():
	var warning = ""
	var grandparent = get_node("../../")
	if !grandparent || !grandparent is Neighbourhood:
		warning = ("This node should be a grandchild of a neighbourhood, child of Transitions")
	return warning
