tool
extends Node2D
export (NodePath) var CurrentHouse setget LoadInside

func LoadInside(house):
	CurrentHouse = house
	if !is_inside_tree():
		return
	clearInsides()
	if !house:
		return
	house = get_node(house)
	get_node("/root/Game/Player").position = house.get_node("PlayerStart").position
	house.show()	

func clearInsides():
	for i in get_children():
		i.hide()
		
