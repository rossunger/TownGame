extends Area2D
export (PackedScene) var nextNeighbourhood

func _on_ToBeaches_body_entered(body):
	print(body.name)
	if body is Player:
		Game.emit_signal("goOutside", {"neighbourhood": nextNeighbourhood})
