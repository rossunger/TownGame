tool
extends Node2D
export (String) var Address #unique ID 
export (NodePath) var Household #who lives here
export (NodePath) var InsideScene #scene to load when inside
export (Texture) var HouseTexture setget setHouseTexture
export var test = "testing"
#export var Location #address? maybe?

func setHouseTexture(value):	
	if !value: 
		return
	HouseTexture = value
	if is_inside_tree():
		get_node("HouseImage").texture = value

func _ready():
	setHouseTexture(HouseTexture)


func _on_GoInsideArea_entered(area):	
	if InsideScene:		
		$GoInsideLabel.visible = true
		area.get_parent().targetAction = {"target": "/root/Game", "function_name": "goInside", "params": get_node(InsideScene).get_path()}
	
func _on_GoInsideArea_exited(area):
	$GoInsideLabel.visible = false	
	
