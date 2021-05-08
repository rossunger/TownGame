extends Node2D

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var id = rng.randi_range(0, get_child_count())
	for i in get_child_count():
		if i != id:
			get_child(i).queue_free()

func _process(delta):
	var dist = abs(global_position.x - Game.player.body.global_position.x)
	if dist > 400:
		modulate.a = 1 - 400 / dist
	else:
		modulate.a = 0
