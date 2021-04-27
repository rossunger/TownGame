tool
extends AnimationPlayer

#export (Array, NodePath) var Cameras = [] setget addNewCamera
#var currentCamera = 0 setget changeCamera

"""
func changeCamera(value):
	if currentCamera != value:		
		currentCamera = value
		Cameras[currentCamera].current = true

func addNewCamera(value):	
	print(value)
	Cameras = value	
func _get_property_list():    
	var properties = []		
	var cameraEnumString = ""
	for i in range(0, Cameras.size()):
		if Cameras[i] is Camera:
			if i == Cameras.size()-1:
				# Do not add a comma
				cameraEnumString += Cameras[i].name
			else:
				# Add a comma
				cameraEnumString += Cameras[i].name + ","
	# add the property
	properties.append({
		"name":currentCamera, 
		"type":TYPE_INT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string":cameraEnumString
	});
	print(properties)
	return properties
#to do: write code that decides which animation to play...
"""
