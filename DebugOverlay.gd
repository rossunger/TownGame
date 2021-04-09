extends CanvasLayer



func _on_goInside_pressed():
	get_node("/root/Game/Player").goInside("/root/Game/Inside/1MainSt")



func _on_goOutside_pressed():
	get_node("/root/Game/Player").goOutside("/root/Game/Outside/MainSt")

