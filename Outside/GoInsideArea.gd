tool
extends Area2D
onready var InsideScene = get_parent().InsideScene

func _on_GoInsideArea_entered(area):
	if area.get_parent() is Player:	
		if InsideScene:				
			Game.addInteractable(self)					
	
func _on_GoInsideArea_exited(area):
	if area.get_parent() is Player:					
		Game.removeInteractable(self)		

func _get_configuration_warning():
	if !get_parent() is OutsideHouse:		
		return "Please make this area a child of an OutsideHouse"
	return ""

func interact():		
	Game.emit_signal("goInside", {"insideHouse": InsideScene.get_path()})	
	Game.removeInteractable(self)
					
	
	
