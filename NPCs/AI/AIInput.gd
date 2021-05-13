tool
extends Node
#class_name AIInput
#this class defines the types of inputs we can have

enum WhoseKnowledge {_myProperty, _targetsProperty, _globalProperty, _equation}
enum AIKnowledgeType {everyAgent, global, equation}
enum AIKnowledgeValueType {fixedValue, fixedRange, dynamicRange}

export var description = "Day Of The Week"
export var value = ""
export (WhoseKnowledge) var whoseKnowledge = WhoseKnowledge._myProperty
export var Parameters = [""]
var Score1IfMatch = false
onready var knowledgeItem = get_child(0)
var myNPC


func _ready():
	if not Engine.editor_hint:
		myNPC = Game.getAncestorOfType(self, NPC)

func set_value(v):
	value = v

func get_value():
	if whoseKnowledge == WhoseKnowledge._globalProperty:		
		return Game.get(Parameters[0])			
	if whoseKnowledge == WhoseKnowledge._myProperty:				
		return myNPC.get(Parameters[0])		

# call once when node selected 
func _get_property_list():
	var property_list = []
	var knowledgeItem = get_child(0)	
	#print(knowledgeItem.valueType)
	if knowledgeItem.valueType == AIKnowledgeValueType.fixedValue:		
		property_list.append({
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "Score1IfMatch",
			"type": TYPE_BOOL
		})    	
		
	return property_list
