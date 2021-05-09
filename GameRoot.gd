extends Node2D

export (PackedScene) onready var PauseMenu = PauseMenu.instance()
func _ready():					
	Game.connect("setPaused", self, "setPaused")	

func setPaused(paused):
	if paused:
		$UI.add_child(PauseMenu)
	else:
		$UI.remove_child(PauseMenu)	
