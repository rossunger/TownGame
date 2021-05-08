extends BaseBody
class_name PlayerBody
var player
func _ready():	
	player = get_parent()
	player.body = self
