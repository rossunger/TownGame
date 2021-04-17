tool
extends Node2D
export (NodePath) var CurrentStreet setget LoadStreet	
onready var tween = get_node("/root/Game/Outside/Tween")
onready var lastPlayerPosition = get_node("/root/Game/Player").position

func _physics_process(delta):
	if !CurrentStreet:
		return
	var playerPos =get_node("/root/Game/Player").position
	var deltaX = lastPlayerPosition.x - playerPos.x
	var deltaY = lastPlayerPosition.y - playerPos.y	
	var cs = get_node(CurrentStreet)
	if 	cs.Street2:
		var st2 = cs.get_node(cs.Street2)
		st2.position.x -= deltaX/4
		st2.position.y -= deltaY/10
	if cs.Street3:
		var st3 = cs.get_node(cs.Street3)	
		st3.position.x -= deltaX/3	
		st3.position.y -= deltaY/8
	lastPlayerPosition = playerPos
	
func LoadStreet(street):	
	if not is_inside_tree():
		return
	#set the actual variable
	CurrentStreet = street	
	#reset all the streets	
	clearStreets(street)
	if !street:				
		toggleColliders(true)
		return	
	toggleColliders(false)
	#get the actual street using it's nodepath and then hide it
	street = get_node(street)	
	street.visible = true
	#if we know what street is needed for parallax, then reparent it there	
	
func clearStreets(currentStreet):	
	for street in get_children():
		if street is Node2D && street.modulate.a != 0:			
			tween.interpolate_property(street, "modulate", street.modulate, Color(1,1,1,0), 0.3, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
			tween.start()
		if street && currentStreet && street.name.ends_with("St"):
			if currentStreet is String || currentStreet is NodePath :
				currentStreet = get_node(currentStreet)
			if currentStreet.name.ends_with("St") && street.z <= currentStreet.z:				
				var s = 1
				if currentStreet.z - street.z == 1:
					s = 0.8
				if currentStreet.z - street.z == 2:
					s = 0.6
				tween.interpolate_property(street, "modulate", street.modulate, Color(s,s,s,1), 0.3, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)				
				
			tween.interpolate_property(street, "position", street.position, street.startPosition, 0.3, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)			
	tween.start()

func toggleColliders(disabled):
	get_node("Floor/FloorShape").set_deferred("disabled", disabled)
	for t in get_node("Transitions").get_children():
		t.get_child(0).set_deferred("disabled", disabled)
