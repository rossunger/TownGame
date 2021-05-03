extends CanvasLayer



func _on_goInside_pressed():
	if Game.timeOfDay == Enums.TimesOfDay.Night:		
		Game.timeOfDay = Enums.TimesOfDay.Morning
		_on_NextDay_pressed()
	else:
		Game.timeOfDay += 1		
	Game.emit_signal("setTimeOfDay", Game.timeOfDay)
	#get_node("/root/Game").goInside("/root/Game/Inside/1MainSt")



func _on_goOutside_pressed():
	Game.emit_signal("goInside")
	#get_node("/root/Game").goOutside("/root/Game/Outside/MainSt")



func _on_NextDay_pressed():
	Game.dayOfTheYear += 1
	Game.emit_signal("setDayOfTheYear")
