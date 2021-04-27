tool
extends Area2D
onready var InsideScene = get_parent().InsideScene

func _on_GoInsideArea_entered(area):		
	add_to_group("interactable")
	if InsideScene:								
		$GoInsideLabel.visible = true				
	
func _on_GoInsideArea_exited(area):			
	remove_from_group("interactable")
	$GoInsideLabel.visible = false	

func _get_configuration_warning():
	if !get_parent() is OutsideHouse:		
		return "Please make this area a child of an OutsideHouse"
	return ""

func interact():
	#get the PlayerStart location from inside the scene we're about to load. so that we can pass it as a parameter
	var s = InsideScene.get_state()
	for i in s.get_node_count():
		if s.get_node_name(i) == "PlayerStart":
			for j in s.get_node_property_count(i):
				if s.get_node_property_name(i, j) == "position":									
					Game.emit_signal("goInside", {"insideHouse": InsideScene.get_path(), "PlayerStart": s.get_node_property_value(i, j)})
					remove_from_group("interactable")
					return		
	
	
