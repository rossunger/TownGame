extends BaseObject
class_name Player


export (bool) var movementEnabled = true;
export (String) var character; #the name of the character we are following

var lastPosition: Vector2

var lastOutsidePlayerPosition  #for when you go inside

var Cam
var CamRemoteTransform
var NearbyArea
var NearbyAreaRemoteTransform
var zoom = 2
var targetZoom = 2

var playerNeighbourhood
var playerStreet
var playerHouse
var playerRoom

func _ready():	
	Game.connect("rideVehicle", self, "rideVehicle")		
	Cam = $PlayerCamera
	Cam.global_position = body.global_position
	CamRemoteTransform = body.get_node("CamRemoteTransform2D")
	CamRemoteTransform.remote_path = Cam.get_path()
	NearbyArea = $NearbyArea
	NearbyArea.global_position = body.global_position
	NearbyAreaRemoteTransform = body.get_node("NearbyAreaRemoteTransform2D")
	NearbyAreaRemoteTransform.remote_path = NearbyArea.get_path()
	teleportOutside("Downtown", "MainSt", Game.getNeighbourhood("Downtown").get_node("PlayerStart").global_position)

func teleportOutside(neighbourhoodName, streetName, globalPosition):	
	NearbyArea.set_collision_layer_bit(Enums.Layers.OutsideArea, true)	
	NearbyArea.set_collision_layer_bit(Enums.Layers.InsideArea, false)
		
	.teleportOutside(neighbourhoodName, streetName, globalPosition)

func _input(ev):
	if Input.is_action_pressed("ui_cancel") && not ev.is_echo():
		Game.setPaused(!Game.isPaused)
	if Input.is_action_pressed("ui_select") && not ev.is_echo():		
		if not currentVehicle:
			Game.doInteraction()
		else:			
			exitVehicle()			
			
func _physics_process(delta):	
	if !Cam:
		return
	get_input();	
	if (abs(zoom - targetZoom) >= 0.01):
		zoom = lerp(zoom, targetZoom, 0.005);
	else: zoom = targetZoom;
	Cam.zoom.x = zoom;
	Cam.zoom.y = zoom;
	if lastPosition != body.position:
		Game.emit_signal("playerMoved", lastPosition.x-body.position.x, lastPosition.y-body.position.y)
		lastPosition = body.position		

func _draw():
	if body.modulate.a != 1:
		print("damn")
	body.modulate.a = 1 
	
func get_input():	
	if Game.isPaused:
		return
	if (movementEnabled): doMovement();	

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
	velocity = velocity.normalized() * speed
	if velocity.length() > 0:
		targetZoom = 2.5
	else:
		targetZoom = 2				

func setCharacter(newCharacter):
	character = newCharacter
	CamRemoteTransform.get_parent().remove_child(CamRemoteTransform)
	
	position = Game.getNPC(newCharacter).position		

func rideVehicle(vehicle):	
	enterVehicle(vehicle)
