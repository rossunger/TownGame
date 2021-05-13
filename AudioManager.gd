extends Node

export (bool) var on setget toggleAudio

func _ready():	
	if on:
		Game.connect("setTimeOfDay", self, "processTimeChange")
		Game.connect("goInside", self, "goInside")
		Game.connect("goOutside", self, "goOutside")
		$Music.play()

func goInside():
	for child in get_children():
		if child is AudioStreamPlayer2D:
			child.volume_db = -40
	
func goOutside():
	for child in get_children():
		if child is AudioStreamPlayer2D:
			child.volume_db = -10
			
func toggleAudio(value):			
	on = value
	if not on:
		for child in get_children():
			if child is AudioStreamPlayer:
				child.stop()
		Game.disconnect("setTimeOfDay", self, "processTimeChange")
	else:
		Game.connect("setTimeOfDay", self, "processTimeChange")
		call_deferred("processTimeChange", Game.timeOfDay)

func processTimeChange(timeOfDay):
	playMorningAudio(timeOfDay == Enums.TimesOfDay.Morning)
	playAfternoonAudio(timeOfDay == Enums.TimesOfDay.Afternoon)		
	playEveningAudio(timeOfDay == Enums.TimesOfDay.Evening)
	playNightAudio(timeOfDay == Enums.TimesOfDay.Night)	
	
func playNightAudio(on):
	if on:
		get_node("Crickets").play()
	else:		
		get_node("Crickets").stop()

func playMorningAudio(on):
	if on:
		get_node("Traffic").play()
	else:		
		get_node("Traffic").stop()

func playAfternoonAudio(on):
	if on:
		get_node("Traffic").play()
	else:		
		get_node("Traffic").stop()
	
func playEveningAudio(on):
	if on:
		get_node("Traffic").play()
	else:		
		get_node("Traffic").stop()
