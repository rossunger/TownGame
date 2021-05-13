tool
extends Area2D
class_name StreetTransition

export (String) var northSt
export (String) var southSt

func _on_Area2D_body_exited(body):			
	var theStreet
	if body.global_position.y < global_position.y:
		theStreet = northSt
	else:
		theStreet = southSt	
	body.parent.setStreet(theStreet)
	#if it's the player, then tell the game to change the street
	if body == Game.player.body:
		Game.changeStreet(theStreet)	

func _get_configuration_warning():
	var warning = ""
	var grandparent = get_node("../../")
	if !grandparent || !grandparent is Neighbourhood:
		warning = ("This node should be a grandchild of a neighbourhood, child of Transitions")
	return warning
