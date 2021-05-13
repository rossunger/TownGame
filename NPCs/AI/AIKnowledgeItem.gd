tool
extends Node
class_name AIKnowledgeItem
export var title = ""
export (Enums.AIKnowledgeType) var type = Enums.AIKnowledgeType.everyAgent setget setKnowledgeType
export (Enums.AIKnowledgeValueType) var valueType = Enums.AIKnowledgeValueType.fixedValue setget setValueType
var minValue = 0
var maxValue = 1000
var fixedValueOptions : Array
var globalVariableName = ""

func setKnowledgeType(value):
	type = value
	property_list_changed_notify()
func setValueType(value):
	valueType = value
	property_list_changed_notify()

# call once when node selected 
func _get_property_list():
	var property_list = []
	if valueType == Enums.AIKnowledgeValueType.fixedRange || valueType == Enums.AIKnowledgeValueType.dynamicRange:
		property_list.append({
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "minValue",
			"type": TYPE_REAL
		})     
		property_list.append({
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "maxValue",
			"type": TYPE_REAL
		})     
	if valueType == Enums.AIKnowledgeValueType.fixedValue:		
		property_list.append({
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "fixedValueOptions",
			"type": TYPE_ARRAY
		})    
	if type == Enums.AIKnowledgeType.global:
		property_list.append({
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "globalVariableName",
			"type": TYPE_STRING
		})    
	return property_list
