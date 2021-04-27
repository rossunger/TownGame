extends Node2D

func _ready():
	Game.connect("setTimeOfDay", self, "switchLight")
	switchLight(Game.timeOfDay)

func switchLight(timeOfDay):
	for child in get_children():
		child.enabled = false
	get_child(timeOfDay).enabled = true
	print(timeOfDay)
		
