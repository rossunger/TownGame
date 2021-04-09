tool
extends Node2D
export (NodePath) var CurrentStreet setget LoadStreet	

func LoadStreet(street):
	if not is_inside_tree():
		return
	#set the actual variable
	CurrentStreet = street
	#reset all the streets
	clearStreets()
	if !street:
		return
	#get the actual street using it's nodepath and then hide it
	street = get_node(street)
	street.visible = true
	#if we know what street is needed for parallax, then reparent it there
	if street.Street2:		
		var street2 = street.get_node(street.Street2)		
		remove_child(street2)
		get_node("ParallaxBackground/Street2").add_child(street2)
		street2.set_owner(self)
		street2.visible = true
		for c in street2.get_children():		
			c.set_owner(self)
	#if we know another street that is needed for parallax, then reparent it there
	if street.Street3:		
		var street3 = street.get_node(street.Street3)
		remove_child(street3)
		get_node("ParallaxBackground/Street3").add_child(street3)
		street3.set_owner(self)
		street3.visible = true
		for c in street3.get_children():		
			c.set_owner(self)
	
func clearStreets():
	#go through each parallax layer and reparent each "street" back to "Outside".
	for parallaxLayer in get_node("ParallaxBackground").get_children():
		for st in parallaxLayer.get_children(): 
			st.get_parent().remove_child(st)
			add_child(st)
			st.set_owner(self)
			#reset each street's scale and position
			st.set_position(Vector2(0,0))
			st.set_scale(Vector2(1,1))
			#don't forget to set_owner on each streets children! otherwise they'll disappear
			for c in st.get_children():
				c.set_owner(self)
	for street in get_children():
		if street is Node2D:
			street.visible = false
	
