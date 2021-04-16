extends CanvasLayer



func _on_goInside_pressed():
	get_node("/root/Game").goInside("/root/Game/Inside/1MainSt")



func _on_goOutside_pressed():
	get_node("/root/Game").goOutside("/root/Game/Outside/MainSt")

