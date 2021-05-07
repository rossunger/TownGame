extends Node2D
class_name BaseObject

var lastParent

func _ready():
	add_to_group("ObjectsInScene")	

func leaveScene():
	get_parent().remove_child(self)
	Game.ObjectManager.add_child(self)	

func returnToScene():
	pass	
	
func teleport():
	#used for when an object needs to suddenly appear somewhere it wasn't before
	pass


"""
Every time we load a neighbourhood, or an inside scene:
	- call get_tree().call_group("ObjectsInScene", "leaveScene") 
	- we check which objects are supposed to be in the new scene, and call returnToScene() on each of them




"""
