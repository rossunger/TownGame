tool
extends Node2D
class_name OutsideHouse
export (NodePath) var Household #who lives here
export (PackedScene) var InsideScene #scene to load when inside
	
func _get_configuration_warning():
	var warning = ""
	var sprite
	var area
	for child in get_children():
		if child is Sprite:
			sprite = child
		if child is Area2D:
			area = child
	if !sprite:
		warning += ("Please add a Sprite for this house \n")
	if !area:
		warning += ("Please add a 'GoInsideArea' for this house \n")
	if !InsideScene:
		warning += ("Please set the InsideScene property \n")
	return warning
