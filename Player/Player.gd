extends BaseObject
class_name Player


export (bool) var movementEnabled = true setget setMovementEnabled;
export (String) var currentCharacterName; #the name of the character we are following

var currentCharacter

var lastPosition: Vector2

var lastOutsidePlayerPosition  #for when you go inside

var Cam
var CamRemoteTransform
var NearbyArea
var NearbyAreaRemoteTransform
var zoom = 1
var zoomTarget = 1
var zoomMax = 2.5 # 1.5  
var zoomMin = 1 # 1

var playerNeighbourhood
var playerStreet
var playerHouse
var playerRoom
var pointAndClick = false
var vehicleCollider

func _ready():	
	Game.connect("rideVehicle", self, "rideVehicle")		
	Cam = $PlayerCamera
	CamRemoteTransform = get_node("CamRemoteTransform2D")
	CamRemoteTransform.remote_path = Cam.get_path()
	NearbyArea = $NearbyArea	
	NearbyAreaRemoteTransform = get_node("NearbyAreaRemoteTransform2D")
	NearbyAreaRemoteTransform.remote_path = NearbyArea.get_path()
	#teleportOutside("Downtown", "MainSt", Game.getNeighbourhood("Downtown").get_node("PlayerStart").global_position)
	movementEnabled = true
	if movementEnabled:
		navEnabled = false		
	vehicleCollider = get_node("vehicleCollider")		
	#body.remove_child(vehicleCollider)

func setMovementEnabled(value):
	movementEnabled = value
	navEnabled = !value

func teleportOutside(neighbourhoodName, streetName, globalPosition):	
	NearbyArea.set_collision_layer_bit(Enums.Layers.OutsideArea, true)	
	NearbyArea.set_collision_layer_bit(Enums.Layers.InsideArea, false)		
	body.parent.teleportOutside(neighbourhoodName, streetName, globalPosition)

func _input(ev):
	if Input.is_action_pressed("ui_cancel") && not ev.is_echo():
		Game.setPaused(!Game.isPaused)
	if Input.is_action_pressed("ui_select") && not ev.is_echo():		
		if not currentVehicle:
			Game.doInteraction()
		else:			
			body.remove_child(vehicleCollider)
			exitVehicle()			
			
func _physics_process(delta):	
	$Destination.global_position = destination
	if !Cam:
		return	
	if (abs(zoom - zoomTarget) >= 0.01):
		zoom = lerp(zoom, zoomTarget, 0.005);
	else: zoom = zoomTarget;
	Cam.zoom.x = zoom;
	Cam.zoom.y = zoom;
	
	get_input();	
	
	if body && lastPosition != body.position:
		Game.emit_signal("playerMoved", lastPosition.x-body.position.x, lastPosition.y-body.position.y)
		lastPosition = body.position		
	
func get_input():	
	if Game.isPaused:
		return
	if (body && movementEnabled): 
		doMovement();	
		velocity = body.move_and_slide(velocity);		
		
		#goToLocation(body.global_position + velocity)

func doMovement():
	velocity = Vector2()	
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed * zoom
	if velocity.length() > 0:
		zoomTarget = zoomMax
	else:
		zoomTarget = zoomMin		

func _unhandled_input(event):
	if pointAndClick && event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			goToLocation(get_canvas_transform().affine_inverse().xform(event.position))

func setCharacter(newCharacter):
	var previousCharacter = currentCharacter			
	currentCharacter = Game.getNPC(newCharacter)
	if currentCharacter.bodyHouse:
		if previousCharacter: 
			Game.endOutside()
		Game.goInside(currentCharacter.bodyHouse, currentCharacter.bodyRoom)		
	else:
		if previousCharacter && previousCharacter.bodyHouse: 
			Game.endInside()
		Game.goOutside(currentCharacter.bodyNeighbourhood, currentCharacter.bodyStreet)			
	CamRemoteTransform.get_parent().remove_child(CamRemoteTransform)
	NearbyAreaRemoteTransform.get_parent().remove_child(NearbyAreaRemoteTransform)
	body = currentCharacter.body
	body.add_child(CamRemoteTransform)
	body.add_child(NearbyAreaRemoteTransform)
	currentCharacter.navEnabled = false
	if previousCharacter && previousCharacter != currentCharacter:
		previousCharacter.navEnabled = true
	

func rideVehicle(vehicle):	
	body.add_child(vehicleCollider)
	enterVehicle(vehicle)
