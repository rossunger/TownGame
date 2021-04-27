extends Node

func _ready():
	Game.connect("setTimeOfDay", self, "setTimeOfDay")
	
func setTimeOfDay(timeOfDay):
	get_node("TimeOfDay").text = Enums.TimesOfDay.keys()[timeOfDay]

