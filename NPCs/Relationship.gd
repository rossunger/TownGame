tool
extends Node
class_name Relationship
var withWho : String setget setWithWho
export var numberOfInteraction = 0

func setWithWho(value):
	if !value:
		return
	name = "RelationshipWith" + value
	withWho = value
	return
