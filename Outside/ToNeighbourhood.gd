extends Area2D
export (String) var GoToNeighbourhood

func _on_ToBeaches_body_entered(body):	
	if body.get("player")!=null:		
		if GoToNeighbourhood:						
			Game.emit_signal("goOutside", {"neighbourhood": load("res://Outside/" + GoToNeighbourhood +".tscn")})
