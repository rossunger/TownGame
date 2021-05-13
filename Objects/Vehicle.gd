extends BaseBody
class_name Vehicle

export var rideable = true
var isBeingRidden = false
export (Enums.VehicleType) var vehicleType
var facingRight = true
onready var collider = $CollisionShape2D

func _ready():
	$AnimationPlayer.play("ride")	
	$AnimationPlayer.playback_speed = 0	
	
func doMovement(velocity):			
	if velocity.length() > 0:		
		if velocity.x > 0 && not facingRight:			
			scale.x = scale.y			
			$InteractionHint.scale.x = 1
			facingRight = true
		if velocity.x < 0 && facingRight:			
			scale.x = scale.y * -1			
			$InteractionHint.scale.x = -1
			facingRight = false
		$AnimationPlayer.playback_speed = 1
		if not $Audio2D.playing:		
			print("startingAudio")
			$Audio2D.play()
			$Tween.interpolate_property($Audio2D, "volume_db", -80, 12, 0.8) 			
			$Tween.disconnect("tween_all_completed", self, "stopAudio")			
			$Tween.start()
	else:					
		$AnimationPlayer.playback_speed = 0
		if $Audio2D.playing && not $Tween.is_active():	
			print("start the stopTween")		
			$Tween.interpolate_property($Audio2D, "volume_db", 12, -80, 0.8) 			
			$Tween.connect("tween_all_completed", self, "stopAudio")			
			$Tween.start()

func stopAudio():
	print("stoppingAudio")
	$Audio2D.stop()

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
	stopAudio()
	$AnimationPlayer.playback_speed = 0
