extends BaseBody
class_name Vehicle

export var rideable = true
var isBeingRidden = false
export (Enums.VehicleType) var vehicleType

func _ready():
	$AnimationPlayer.play("ride")	
	$AnimationPlayer.playback_speed = 0	
	
func _physics_process(delta):
	var parent = get_parent()
	if parent is PlayerBody && parent.velocity.length() > 0:
		if parent.velocity.x > 0:
			scale.x = 1
			$InteractionHint.scale.x = 1
		if parent.velocity.x < 0:
			scale.x = -1		
			$InteractionHint.scale.x = -1
		$AnimationPlayer.playback_speed = 1
	else:
		$AnimationPlayer.playback_speed = 0

func onRideMeAreaEntered(area):			
	if rideable && not isBeingRidden && area.get_parent() is Player:
		Game.addInteractable(self)		
		
func onRideMeAreaExited(area):				
	if rideable && not isBeingRidden && area.get_parent() is Player:
		Game.removeInteractable(self)
		

func interact():	
	if not isBeingRidden:
		isBeingRidden = true	
		Game.emit_signal("rideVehicle", {"vehicle": self})			
		get_node("InteractionHint").visible = false
		
func endRiding():	
	isBeingRidden = false	


