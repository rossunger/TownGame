tool
extends Node
class_name MyRelationships
func newRelationship(withWho):
	var r = load("res://NPCs/Relationship.tscn").instance()
	if !has_node("RelationshipWith" + withWho):		
		r.withWho = withWho		
		add_child(r)
		r.owner = get_parent()		







"""
export (bool) var refresh = false setget doUpdateRelationshipList

func doUpdateRelationshipList(value):
	var NPCManager = load("res://NPCManager.tscn")
	var RelationshipTemplate = load("res://NPCs/Relationship.tscn")
	for node in get_children():
		remove_child(node)
		node.queue_free()		
	for i in NPCManager._bundled.node_count-1:
		var charName = NPCManager.get_state().get_node_name(i+1)		
		var r = RelationshipTemplate.instance()
		r.withWho = charName	
		
		add_child(r)
		r.owner = self
		var scene = PackedScene.new()
		# Only `node` and `rigid` are now packed.
		var result = scene.pack(self)
		if result == OK:
			var error = ResourceSaver.save("res://NPCs/NPCData/MyRelationships.tscn", scene) 
			print(error)
"""
