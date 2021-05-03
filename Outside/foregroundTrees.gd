extends Node2D
export var numberOfTrees = 15
export (PackedScene) var foregroundTreeScene 

func _ready():	
	var rng = RandomNumberGenerator.new()
	rng.randomize()		
	#randomly place some trees
	for i in numberOfTrees:
		var tree = foregroundTreeScene.instance()		
		tree.position.x = Game.player.position.x - rng.randi_range(-2500, 2500)		
		add_child(tree)		
		
