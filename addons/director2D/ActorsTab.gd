tool
extends GridContainer

"""
1. get list of characters
2. select which ones are in the scene
3. add locations where they go
"""
var allcharacters = []
var filteredCharacters
var charactersInScene = [] 
var animation

func _ready():
	get_owner().connect("LoadAnimation", self, "LoadSceneCharacters")		
	updateCharacterList()
	

func updateCharacterList():	
	var npcmanager = load("res://NPCs/NPCManager.tscn").instance()
	allcharacters = []
	for child in npcmanager.get_children():
		allcharacters.append(child.name)			
	npcmanager.free()	
	_on_SearchBox_doSearch("")
	
func _on_SearchBox_doSearch(searchTerm):	
	filteredCharacters = []	
	var parent = get_node("AllCharacterList")
	for child in parent.get_children():
		parent.remove_child(child)	
	for character in allcharacters:		
		if character.findn(searchTerm) && searchTerm != "":
			pass
		else:
			filteredCharacters.append(character)
			var button = Button.new()
			button.text = character
			button.connect("pressed", self, "addCharactersToScene", [[character]])
			parent.add_child( button )				

func addCharactersToScene(characters):
	for character in characters:
		if !charactersInScene.has(character):
			charactersInScene.append(character)
		if allcharacters.has(character):
			allcharacters.remove(allcharacters.find(character))
	_on_SearchBox_doSearch("")		
	updateCharactersInScene()
	get_owner().charactersInScene = charactersInScene
	
func removeCharacterFromScene(character):	
	if charactersInScene.has(character):
		charactersInScene.remove(charactersInScene.find(character))
	if !allcharacters.has(character):
		allcharacters.append(character)
	_on_SearchBox_doSearch("")		
	updateCharactersInScene()

func updateCharactersInScene():
	var parent = get_node("CharactersInScene/CharacterList")
	for child in parent.get_children():
		child.queue_free()		
	for character in charactersInScene:
		var button = Button.new()
		button.text = character
		button.connect("pressed", self, "removeCharacterFromScene", [character])
		parent.add_child(button)
	if animation:
		addCharactersToTimeline(animation)
	else:
		print("no anim")
					
func LoadSceneCharacters(anim):
	animation = anim
	var characters = []
	for i in anim.get_track_count():
		var t = str(anim.track_get_path(i))
		if t.find("NPCManager") != -1:
			t = t.right(t.find("/")+1)
			t = t.left(t.find(":"))
			characters.append(t)
	addCharactersToScene(characters)

func addCharactersToTimeline(anim):		
	var tracksToRemove = []
	var tc = anim.get_track_count()
	for i in tc:
		var t = str(anim.track_get_path(i))
		if t.find("NPCManager") != -1:
			t = t.right(t.find("/")+1)
			t = t.left(t.find(":"))
			print("considering: " +t)
			if !charactersInScene.has(t):
				print("another track to remove: "+ t)
				tracksToRemove.append(i)
	for i in tracksToRemove.size():
		var ttr = tracksToRemove[tracksToRemove.size()-i-1]
		anim.remove_track(ttr)	
	for character in charactersInScene:
		if anim.find_track("NPCManager/" + character + ":position:x") == -1:
			var trackX = anim.add_track(Animation.TYPE_BEZIER)
			anim.track_set_path(trackX, "NPCManager/" + character + ":position:x")
			anim.track_insert_key(trackX, 0.0,  [0, -0.25, 0, 0.25, 0 ])
		if anim.find_track("NPCManager/" + character + ":position:y") == -1:
			var trackY = anim.add_track(Animation.TYPE_BEZIER)
			anim.track_set_path(trackY, "NPCManager/" + character + ":position:y")
			anim.track_insert_key(trackY, 0.0,  [0, -0.25, 0, 0.25, 0 ])
			
	property_list_changed_notify()		
	get_owner().saveAnimation()
