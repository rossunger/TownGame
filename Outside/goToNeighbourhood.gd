extends Area2D
class_name goToNeighbourhood
export (String) var GoToNeighbourhood
export (String) var GoToStreet

func _on_ToBeaches_body_entered(body):	
	#if it's the player, then change the scene
	if body.get("player")!=null:		
		if GoToNeighbourhood:									
			var waypoint = "From" + get_owner().name
			var street = Game.getStreet(GoToNeighbourhood, GoToStreet)
			Game.player.teleportOutside(GoToNeighbourhood, GoToStreet, street.get_node(waypoint).global_position)
			#Game.emit_signal("goOutside", {"neighbourhood": GoToNeighbourhood})	
