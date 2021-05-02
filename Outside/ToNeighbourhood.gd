extends Area2D
export (String) var GoToNeighbourhood

func _on_ToBeaches_body_entered(body):
	print(body.name)
	if body is Player:		
		if GoToNeighbourhood:						
			Game.emit_signal("goOutside", {"neighbourhood": load("res://Outside/" + GoToNeighbourhood +".tscn")})
