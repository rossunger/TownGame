extends Node2D
export var carsPerMinute = 2 #cars per minute
export (PackedScene) var carScene
export var carsGoLeft = true
var tick = 0

func _process(delta):
	tick += 1	
	if tick % (60*60/carsPerMinute) == 0:
		tick = 1		
		if carsPerMinute > 0:
			var car = carScene.instance()
			car.left = carsGoLeft
			add_child(car)				
