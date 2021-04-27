tool
extends Camera2D

export(NodePath) var focusCharacter setget changeCharacter
export(Resource) var preset setget loadPreset 
var transitionTime = 0.0

func changeCharacter(value):
	focusCharacter = value
	
	
func loadPreset(newPreset: CameraPreset):	
	preset = newPreset
	zoom = Vector2(preset.zoom,preset.zoom)
	property_list_changed_notify()

func changeShot():
	if transitionTime == 0:
		#snap cut
		pass
