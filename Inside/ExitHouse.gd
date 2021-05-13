extends Area2D

export (String) var neighbourhoodName
export (String) var streetName

func exitHouse(body):
	if Game.inside.visible == true:
		if body == Game.player.body:
			Game.goOutside(neighbourhoodName, streetName)	
		if body is BaseBody:
			var pos = Game.getStreet(neighbourhoodName, streetName).get_node(get_owner().name + "/GoInsideArea").global_position
			body.parent.teleportOutside(neighbourhoodName, streetName, pos)
