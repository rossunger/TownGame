extends Node2D
var left = true
export (Array, Texture) var carSprites = []
const MAX_DISTANCE_FROM_PLAYER = 1500
var CAR_SPEED = 15

func _ready():	
	var rng = RandomNumberGenerator.new()
	rng.randomize()	
	get_node("Sprite").texture = carSprites[rng.randi_range(0, carSprites.size()-1)]
	position.y = get_parent().position.y
	if left:
		global_position.x = Game.player.body.global_position.x + MAX_DISTANCE_FROM_PLAYER
	else:
		global_position.x = Game.player.body.global_position.x - MAX_DISTANCE_FROM_PLAYER
		scale.x = -1

func _process(delta):
	if left:
		position.x -= CAR_SPEED
	else:
		position.x += CAR_SPEED
	
	if abs(Game.player.body.global_position.x - global_position.x) > MAX_DISTANCE_FROM_PLAYER:
		queue_free()
