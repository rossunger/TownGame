extends Node2D
var left = true
export (Array, Texture) var carSprites = []
const MAX_DISTANCE_FROM_PLAYER = 1500
const CAR_SPEED = 15

func _ready():	
	var rng = RandomNumberGenerator.new()
	rng.randomize()	
	get_node("Sprite").texture = carSprites[rng.randi_range(0, carSprites.size()-1)]
	position.y = get_parent().position.y
	if left:
		position.x = Game.player.position.x + 1500
	else:
		position.x = Game.player.position.x - 1500
		scale.x = -1

func _process(delta):
	if left:
		position.x -= CAR_SPEED
	else:
		position.x += CAR_SPEED
	
	if abs(Game.player.position.x - position.x) > MAX_DISTANCE_FROM_PLAYER:
		queue_free()
