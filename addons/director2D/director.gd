tool
extends Control

signal LoadAnimation

var anim
var goToLocation
var sceneName = ""
var charactersInScene
	
func setGoToLocation(path):			
	if anim:		
		goToLocation = ""
		var track 
		if anim.find_track("Director") != -1:
			anim.remove_track(anim.find_track("Director"))
		track = anim.add_track(Animation.TYPE_METHOD)
		anim.track_set_path(track, "Director")		
		if path.find("Outside") != -1:					
			anim.track_insert_key(track, 0.0, {"args": [ path ], "method": "emitGoOutside"})	
			print("OUTSIDEEEE")		
		if path.find("Inside") != -1:
			anim.track_insert_key(track, 0.0, {"args": [ path ], "method": "emitGoInside"} )		
		saveAnimation()		
		var rootNode = get_tree().get_edited_scene_root()		
		if rootNode && rootNode.has_node("DEBUG"):
			var debugNode = rootNode.get_node("DEBUG")		
			if debugNode:
				debugNode.clearChildren()			
				var scene = load(path).instance()			
				var child = debugNode.add_child(scene)
				scene.set_owner(rootNode)		
	else:		
		goToLocation = path

func createAnimationButtonPressed(animName):			
	sceneName = animName
	createAnimation()		
	saveAnimation()
	
func loadAnimation(animName):
	sceneName = animName
	anim = load("res://Timelines/Animations/" + sceneName + ".tres")			
	emit_signal("LoadAnimation", anim)

func createAnimation():	
	if !ResourceLoader.exists("res://Timelines/Animations/" + sceneName + ".tres"):
		anim = Animation.new()							
	
func saveAnimation():
	print("scene name: " + sceneName)
	ResourceSaver.save("res://Timelines/Animations/" + sceneName + ".tres", anim)

func renameScene():
	pass
	

