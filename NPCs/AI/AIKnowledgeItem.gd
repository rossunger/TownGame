tool
extends Node
class_name AIKnowledgeItem
enum AIKnowledgeType {everyAgent, global, equation}
enum AIKnowledgeValueType {fixedValue, fixedRange, dynamicRange}
export var title = ""
export (AIKnowledgeType) var type = AIKnowledgeType.everyAgent setget setKnowledgeType
export (AIKnowledgeValueType) var valueType = AIKnowledgeValueType.fixedValue setget setValueType
var MinValue = 0
var MaxValue = 1000
var FixedValue : Array
var GlobalVariableName = ""

func setKnowledgeType(value):
	type = value
	property_list_changed_notify()
func setValueType(value):
	valueType = value
	property_list_changed_notify()

# call once when node selected 
func _get_property_list():
	var property_list = []
	if valueType == AIKnowledgeValueType.fixedRange || valueType == AIKnowledgeValueType.dynamicRange:
		property_list.append({
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "MinValue",
			"type": TYPE_REAL
		})     
		property_list.append({
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "MaxValue",
			"type": TYPE_REAL
		})     
	if valueType == AIKnowledgeValueType.fixedValue:		
		property_list.append({
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "FixedValue",
			"type": TYPE_ARRAY
		})    
	if type == AIKnowledgeType.global:
		property_list.append({
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "GlobalVariableName",
			"type": TYPE_STRING
		})    
	return property_list
