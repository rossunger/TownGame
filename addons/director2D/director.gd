tool
extends Control

var anim
export (NodePath) onready var AnimationTab = get_node(AnimationTab)
export (NodePath) onready var CharactersTab = get_node(CharactersTab)

func createAnimationButtonPressed():
	loadOrCreateAnimation(AnimationTab.get_node("AnimationName").text)
	addCharactersToScene(CharactersTab.charactersInScene)
	saveAnimation(AnimationTab.get_node("AnimationName").text, anim)
	
func loadOrCreateAnimation(sceneName):
	if !ResourceLoader.exists("res://Timelines/Animations/" + sceneName + ".tres"):
		anim = Animation.new()
		saveAnimation(sceneName, anim)
	else:
		anim = ResourceLoader.load("res://Timelines/Animations/" + sceneName + ".tres")		

func saveAnimation(sceneName, animation):
	ResourceSaver.save("res://Timelines/Animations/" + sceneName + ".tres", animation)

func renameScene():
	pass
	
func addCharactersToScene(characters: Array):
	for character in characters:
		if anim.find_track(character + ":position:x") == -1:					
			var trackX = anim.add_track(Animation.TYPE_BEZIER)
			var trackY = anim.add_track(Animation.TYPE_BEZIER)			
			anim.track_set_path(trackX, character + ":position:x")
			anim.track_set_path(trackY, character + ":position:y")
			anim.track_insert_key(trackX, 0.0,  [0, -0.25, 0, 0.25, 0 ])
			anim.track_insert_key(trackY, 0.0,  [0, -0.25, 0, 0.25, 0 ])
					
	property_list_changed_notify()		


