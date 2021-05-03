tool
extends Label

func _ready():
	get_tree().connect("files_dropped", self, "setAnimation")

func setAnimation(files:PoolStringArray, screen: int):
	if get_parent().visible:
		#on drag and drop, load the Resource file, and then localize it's path 
		#(replace the \ with / to accomodate for windows being stupid )	
		if files[0].find(".tres") != -1:
			var pathToResource = ProjectSettings.localize_path(files[0].replace('\\', '/' ))
			text = pathToResource.get_basename().right(pathToResource.rfind("/")+1)
			get_owner().loadAnimation(text)
