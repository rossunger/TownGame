extends Node2D

var isHiding = false;
var isSafe = true;
var hidingLength = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (isSafe):
		# if is hiding, wait X seconds, then stop hiding
		if (isHiding):
			hidingLength += delta;
			
			pass;
	else:
		# init escape
		escape();
		pass;
	
	if (isHiding):
	# 	check for nearby human (stay in escape mode)
		checkSafety();
		pass;
	# if no nearby human, wait X seconds, and exit escape mode.

	
func checkSafety():
	# var isSafe = false;
	
	pass;
	
func _on_Area2D_area_entered(area):
	if area.get_parent().name == "Character":
		escape();
		pass;

		# var d = Dialogic.start("TEST");
		# if (get_node("CanvasLayer").get_child_count()==0):
			# get_node("CanvasLayer").add_child(d);
		# else: area.get_parent().add_child(d);
	
	
func escape():
	# escape is just finish animation asap and stay at animation start point
	# once escaped, you are hiding
	pass;
