extends CanvasLayer



func _on_goInside_pressed():
	Game.emit_signal("goOutside")
	#get_node("/root/Game").goInside("/root/Game/Inside/1MainSt")



func _on_goOutside_pressed():
	Game.emit_signal("goInside")
	#get_node("/root/Game").goOutside("/root/Game/Outside/MainSt")

