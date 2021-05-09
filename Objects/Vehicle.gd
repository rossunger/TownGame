extends BaseBody
class_name Vehicle

export var rideable = true
var isBeingRidden = false
export (Enums.VehicleType) var vehicleType
var facingRight = true

func _ready():
	$AnimationPlayer.play("ride")	
	$AnimationPlayer.playback_speed = 0	
	
func doMovement(velocity):			
	if velocity.length() > 0:		
		if velocity.x > 0 && not facingRight:
			scale.x = 1			
			$InteractionHint.scale.x = 1
			facingRight = true
		if velocity.x < 0 && facingRight:
			scale.x = -1					
			$InteractionHint.scale.x = -1
			facingRight = false
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
		Game.emit_signal("rideVehicle", self)			
		get_node("InteractionHint").visible = false
		
func exitVehicle():	
	var pos = global_position
	var par = get_parent()
	par.remove_child(self)
	par.get_parent().add_child(self)		
	isBeingRidden = false	
	global_position = pos	
	$AnimationPlayer.playback_speed = 1
