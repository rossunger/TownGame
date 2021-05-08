extends Node2D

export (NodePath) var firstRoom
var currentZ
func _ready():
	currentZ = get_node(firstRoom).z
	Game.CurrentStreetOrRoom = get_node(firstRoom)
	#Hide all the rooms that aren't visible
	for room in $Rooms.get_children():							
		if room.z > currentZ:
			room.modulate.a = 0
		else:
			room.modulate.a = 1

func _on_Area2D_body_entered(body):
	if Game.CurrentStreetOrRoom is Room && body.get("player")!=null:		
		if not Game.lastStreet:
			print("Error: no last street")			
		body.player.bodyStreetOrRoom = Game.lastStreet
		body.player.bodyInside = null
		Game.emit_signal("goOutside", {"neighbourhood": load(Game.CurrentNeighbourhood.filename), "street":Game.lastStreet})
