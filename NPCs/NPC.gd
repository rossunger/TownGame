tool
extends Node2D
export(Resource) var daysThatIWork = daysThatIWork as DaysThatIWork

func _get_configuration_warning():
	var warning:= PoolStringArray()
	var hasBrain = false
	#var hasBrain = false
	for child in get_children():		
		if child is Brain:
			hasBrain=true
	if !hasBrain:
		warning.append("%s is missing a Brain" % name)
	return warning.join("/n")

func set(param, value):
	print("setting: " + param)


func _on_renamed():	
	get_node("NameLabel").text = name	
	var label = get_node("MyRelationships").get_child(0)
	label.name = name
	label.set_owner(get_parent())
	
func set_emotion(emotion:String, value:float, relative=true):
	if relative:
		get_node("MyEmotions")[emotion] += value
	else:
		get_node("MyEmotions")[emotion] = value	
	get_node("EmotionLabel").text = get_node("MyEmotions").getLargestEmotionName()


#Insert AI functinos here??	
func stopAndWait():
	print("im stopping and waiting")
	#play idle animation
	#target location = null

func goToLocation(location):
	print("im going to location: " + location)


""" List of INSTRUCTIONS an ACTION can give a CHARACTER
Wait
Walk somewhere
Talk to someone
Change Parameter [emotional state, belief, wealth, etc)
Interact with object (call a function on that object)

SEQUENCES (complex actions)
Deliver object to person
- walk to object
- change Parameter (pick up object)
- walk to person
- change parameter (give object to person)


List of STATES a CHARACTER can be in
- waiting
- walking
- talking
- interacting (with object)
- thinking? (is this the same as waiting?)




Feel / Change an Emotion
Go somewhere
Go to work / do work
Help someone 
Do recreational activity - Play with person/object/imagination, watch TV
Create something
Destroy something
Contemplate / Think about something
Meditate / Feel into yourself
Buy/Sell something



"""
