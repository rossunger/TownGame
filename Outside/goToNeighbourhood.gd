extends Area2D
class_name goToNeighbourhood
export (String) var GoToNeighbourhood
export (String) var GoToStreet

func _on_ToBeaches_body_entered(body):	
	if not body is BaseBody:
		return
	if GoToNeighbourhood:									
		var waypoint = "From" + get_owner().name
		var street = Game.getStreet(GoToNeighbourhood, GoToStreet)
		#if it's the player, then change the scene
		if Game.player.body == body:				
			Game.player.teleportOutside(GoToNeighbourhood, GoToStreet, street.get_node(waypoint).global_position)
		else:
			body.parent.teleportOutside(GoToNeighbourhood, GoToStreet, street.get_node(waypoint).global_position)
			
