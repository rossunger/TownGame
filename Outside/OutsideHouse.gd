tool
extends Node2D
class_name OutsideHouse
export (String) var household #name of household at this house
export (String) var address = name
	
func _ready():
	if household:
		$HouseholdLabel.text = household + " Family"
	
func _get_configuration_warning():
	var warning = ""
	var sprite
	var area
	for child in get_children():
		if child is Sprite:
			sprite = child
		if child is Area2D:
			area = child
	if not sprite:
		warning += ("Please add a Sprite for this house \n")
	if not area:
		warning += ("Please add a 'GoInsideArea' for this house \n")
	if not address:
		warning += ("Please add an Address \n")
	return warning
