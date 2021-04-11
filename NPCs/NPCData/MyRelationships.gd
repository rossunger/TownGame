
extends Node
class_name MyRelationships
var relationships
export (PackedScene) var NPCManager = preload("res://NPCManager.tscn")
export (bool) var refresh = false setget doUpdateRelationshipList
var RelationshipTemplate = preload("res://NPCs/Relationship.tscn")

func doUpdateRelationshipList(value):
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
