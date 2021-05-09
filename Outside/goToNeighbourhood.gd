extends Area2D
class_name goToNeighbourhood
export (String) var GoToNeighbourhood

func _on_ToBeaches_body_entered(body):	
	#if it's the player, then change the scene
	if body.get("player")!=null:		
		if GoToNeighbourhood:						
			Game.emit_signal("goOutside", {"neighbourhood": GoToNeighbourhood})	
