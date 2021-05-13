tool
extends Area2D
onready var address = get_parent().address

func _on_GoInsideArea_entered(area):
	if area.get_parent() is Player:	
		if address && Game.inside.has_node(address):				
			Game.addInteractable(self)					
	
func _on_GoInsideArea_exited(area):
	if area.get_parent() is Player:					
		Game.removeInteractable(self)		

func _get_configuration_warning():
	if !get_parent() is OutsideHouse:		
		return "Please make this area a child of an OutsideHouse"
	return ""

func interact():		
	Game.goInside(address, Game.getHouse(address).firstRoom)
	Game.player.body.parent.teleportInside(address, Game.getHouse(address).firstRoom, Game.getHouse(address).get_node("PlayerStart").global_position)
	Game.removeInteractable(self)
