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

func _ready():
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
			button.connect("pressed", self, "addCharacterToScene", [character])
			parent.add_child( button )				

func addCharacterToScene(character):
	if !charactersInScene.has(character):
		charactersInScene.append(character)
	if allcharacters.has(character):
		allcharacters.remove(allcharacters.find(character))
		_on_SearchBox_doSearch("")		
	updateCharactersInScene()

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
		
