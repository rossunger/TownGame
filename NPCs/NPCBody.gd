extends BaseBody
class_name NPCBody

func _ready():
	doRename()

func doRename():	
	$NameLabel.text = name	

