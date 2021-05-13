extends CanvasLayer



func _on_goInside_pressed():
	Game.setNextTimeOfDay()
	#get_node("/root/Game").goInside("/root/Game/Inside/1MainSt")



func _on_goOutside_pressed(who):
	Game.player.setCharacter(who)



func _on_NextDay_pressed():
	Game.setNextDayOfYear()		


func toggleRain():
	var env = get_node("/root/GameRoot/EnvironmentManager")
	env.raining = !env.raining
	if Game.player.body.parent.bodyHouse:
		env.processGoInside()
	else:
		env.processGoOutside()
