extends Node2D
	
func setPlayerPosition():
	Game.player.position = position


func _on_PlayerStart_tree_entered():
	setPlayerPosition()
