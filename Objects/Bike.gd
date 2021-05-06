extends Node2D

export var rideable = true
var isBeingRidden = false

func _ready():
	$AnimationPlayer.play("ride")	
	$AnimationPlayer.playback_speed = 0	
	
func _physics_process(delta):
	var parent = get_parent()
	if parent is Player && parent.velocity.length() > 0:
		if parent.velocity.x > 0:
			scale.x = 1
		if parent.velocity.x < 0:
			scale.x = -1		
		$AnimationPlayer.playback_speed = 1
	else:
		$AnimationPlayer.playback_speed = 0

func onRideMeAreaEntered(area):			
	if rideable:
		add_to_group("interactable")		
		$RideMeLabel.visible = true
	
func onRideMeAreaExited(area):				
	if rideable:
		remove_from_group("interactable")
		$RideMeLabel.visible = false	

func interact():	
	if not isBeingRidden:
		Game.emit_signal("rideBike", {"bike": self})	
		remove_from_group("interactable")
