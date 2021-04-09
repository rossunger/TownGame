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
	house.visible = true;

func clearInsides():
	for i in get_children():
		i.visible=false
