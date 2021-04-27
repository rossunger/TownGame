extends Control

export (NodePath) onready var mainControl = get_node(mainControl)
export (NodePath) onready var optionsControl = get_node( optionsControl )


func _on_Continue_pressed():
	Game.setPaused(false)


func _on_Exit_pressed():
	get_tree().quit()


func _on_Options_pressed():
	mainControl.visible = false
	optionsControl.visible = true


func _on_Back_pressed():
	mainControl.visible = true
	optionsControl.visible = false	
