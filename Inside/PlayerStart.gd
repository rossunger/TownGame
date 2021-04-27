extends Node2D
	
func setPlayerPosition():
	Game.setPlayerPosition(position)	


func _on_PlayerStart_tree_entered():
	setPlayerPosition()
