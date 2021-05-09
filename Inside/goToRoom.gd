extends Area2D

export (String) var northRoom
export (String) var southRoom
export (String) var eastRoom
export (String) var westRoom

func onBodyExited(body):
	if not body is BaseBody:
		return	
	var nextRoomName:String
	var currentRoomName:String
	if northRoom:
		if body.global_position.y < global_position.y:				
			nextRoomName = northRoom
			currentRoomName = southRoom				
		else:
			nextRoomName = southRoom
			currentRoomName = northRoom				
	#TO DO - test the west/east transitions... we might need to flip the > sign
	if westRoom:
		if body.global_position.x > global_position.x:	
			nextRoomName = eastRoom
			currentRoomName = westRoom				
		else:
			nextRoomName = westRoom
			currentRoomName = eastRoom					
	
	var nextRoom = get_owner().get_node("Rooms/" + nextRoomName)
	var currentRoom = get_owner().get_node("Rooms/" + currentRoomName)
		
	#if it's the player, then do the room transition			
	if body.get("player")!=null:									
		get_owner().doRoomTransition(currentRoom, nextRoom, nextRoom.name == southRoom)
	
	#move body to the new room
	body.parent.setRoom(nextRoomName)	
	
