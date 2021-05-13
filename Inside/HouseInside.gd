extends Node2D

export (String) var firstRoom
var currentZ
func _ready():
	currentZ = get_node("Rooms/" + firstRoom).z	
	#Hide all the rooms that aren't visible
	for room in $Rooms.get_children():							
		if room.z > currentZ:
			room.modulate.a = 0
		else:
			room.modulate.a = 1

func doRoomTransition(currentRoom, nextRoom, isTransitionSouth):
	var tween = get_node("Tween")
	#fade in new room if it's hidden
	if nextRoom.modulate.a != 1:
		Game.tween.interpolate_property(nextRoom, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.3, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)					
	#fade out current room, unless we're going south, in which case it's not in the way
	if not isTransitionSouth && currentRoom:
		Game.tween.interpolate_property(currentRoom, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.3, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)	
	Game.tween.start()
	
