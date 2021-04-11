extends Node
class_name MyEmotions
export (float) var anger = 3
export (float) var sadness = 0
export (float) var happiness = 0
export (float) var surprise = 0
export (float) var disgust = 7
export (float) var fear = 0
const emotions = ["anger", "sadness", "happiness", "surprise", "disgust", "fear"]

func getLargestEmotionName():
	var largest = "anger"
	for e in emotions:
		if get(e) > get(largest):
			largest = e		
	return largest
