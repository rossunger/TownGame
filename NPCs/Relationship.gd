tool
extends Node
class_name Relationship
var withWho : String setget setWithWho

func setWithWho(value):
	if !value:
		return
	name = "RelationshipWith" + value
	withWho = value
	return
