extends Node2D

export var raining = true

func _ready():
	Game.connect("setTimeOfDay", self, "switchLight")	
	Game.connect("goInside",self,"processGoInside")
	Game.connect("goOutside",self,"processGoOutside")
	switchLight(Game.timeOfDay)			

func switchLight(timeOfDay):
	for child in get_children():
		if child is Light2D:
			child.enabled = false
	get_child(timeOfDay).enabled = true	

func processGoOutside():
	$Rain/RainSpecks.visible = true if raining else false 
	call_deferred("toggleRainAudio", raining)
	
func processGoInside():
	$Rain/RainSpecks.visible = false		
	call_deferred("toggleRainAudio", raining)
	
func toggleRainAudio(enable):
	var audioNode = $Rain/RainInsideAudio if Game.player.body.parent.bodyHouse != "" else $Rain/RainOutsideAudio
	var otherAudioNode = $Rain/RainInsideAudio if Game.player.body.parent.bodyHouse == "" else $Rain/RainOutsideAudio
	print(Game.player.body.parent.bodyHouse)
	otherAudioNode.stop()
	if enable: audioNode.play(5)
	else: audioNode.stop()

#WEATHER
# snow
# rain
# storm / lightning
# wind
# birds and crickets
# mosquitos and bugs
