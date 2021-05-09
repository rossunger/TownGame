tool
extends Area2D
onready var Address = get_parent().Address

func _on_GoInsideArea_entered(area):
	if area.get_parent() is Player:	
		if Address:				
			Game.addInteractable(self)					
	
func _on_GoInsideArea_exited(area):
	if area.get_parent() is Player:					
		Game.removeInteractable(self)		

func _get_configuration_warning():
	if !get_parent() is OutsideHouse:		
		return "Please make this area a child of an OutsideHouse"
	return ""

func interact():		
	Game.goInside(Address, Game.getHouse(Address).firstRoom)
	Game.player.teleportInside(Address, Game.getHouse(Address).firstRoom, Game.getHouse(Address).get_node("PlayerStart").global_position)
	Game.removeInteractable(self)
