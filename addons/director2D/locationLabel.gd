tool
extends Label
var pathToScene = ""
# checks if we can recive the dropped data
func _ready():
	get_tree().connect("files_dropped", self, "setLocation")
	get_owner().connect("LoadAnimation", self, "loadLocation")
	
func setLocation(files:PoolStringArray, screen: int):
	if get_parent().visible:		
	#on drag and drop, load the PackedScene file, and then localize it's path 
	#(replace the \ with / to accomodate for windows being stupid )
		var tmp = load(files[0])
		if tmp is PackedScene:
			pathToScene = ProjectSettings.localize_path(files[0].replace('\\', '/' ))
			text = pathToScene #tmp.get_state().get_node_name(0)		
		get_owner().setGoToLocation(pathToScene)	

func loadLocation(anim):		
	var i = anim.find_track("Director")
	if i == -1:
		return	
	var k = anim.track_find_key(i, 0.0)
	if k == -1:
		return
	if anim.track_get_type(i) == 2:
		var data = anim.track_get_key_value(i, k)		
		if data.args[0]:
			return
		pathToScene = data.args[0]
		text = pathToScene	
		get_owner().setGoToLocation(pathToScene)
