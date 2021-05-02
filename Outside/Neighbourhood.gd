extends Node2D
class_name Neighbourhood
var currentStreet	
onready var tween = get_node("Tween")
export(NodePath) onready var firstStreet = get_node(firstStreet)

func _ready():		
	Game.connect("playerMoved", self, "doParallax")			
	LoadStreet(firstStreet)
	
func doParallax(deltaX, deltaY):
	if currentStreet:		
		if currentStreet.Street2:
			var st2 = currentStreet.get_node(currentStreet.Street2)
			st2.position.x -= deltaX/4
			st2.position.y -= deltaY/10
		if currentStreet.Street3:
			var st3 = currentStreet.get_node(currentStreet.Street3)	
			st3.position.x -= deltaX/3	
			st3.position.y -= deltaY/8	
		
		
	
func LoadStreet(street):
	#set the actual variable
	currentStreet = street					
	#go through each street...
	for st in get_children():		
		#if it's a street, then set it's modulation color based on it's Z property
		var j = st.name
		#if we don't have a current street, start by hiding everyone.
		if !currentStreet && st is Street && st.modulate.a != 0:			
			tween.interpolate_property(street, "modulate", street.modulate, Color(1,1,1,0), 0.3, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
			tween.start()			
		elif st is Street && currentStreet is Street:			
			if st.z <= currentStreet.z:				
				var s = 1
				if currentStreet.z - st.z == 1:
					s = 0.8
				if currentStreet.z - st.z == 2:
					s = 0.6
				tween.interpolate_property(st, "modulate", st.modulate, Color(s,s,s,1), 0.3, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)								
			else:
				print("TEST")
				if currentStreet != st:
					tween.interpolate_property(st, "modulate", st.modulate, Color(1,1,1,0), 0.3, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)																		
			tween.interpolate_property(street, "position", street.position, street.startPosition, 0.3, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)			
	tween.start()		
