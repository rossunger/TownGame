tool
extends Node2D
export (NodePath) var CurrentHouse setget LoadInside

func LoadInside(house):
	CurrentHouse = house		
	if !is_inside_tree():
		return
	clearInsides()
	if !house:		
		visible = false
		return	
	house = get_node(house)
	get_node("/root/Game/Player").position = house.get_node("PlayerStart").position
	house.show()	
	visible = true

func clearInsides():
	for i in get_children():
		i.hide()	
