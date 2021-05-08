extends BaseObject
class_name Player

export (int) var speed = 300
export (bool) var movementEnabled = true;
export(Enums.viewMode) var view_mode = 0;
export(NodePath) var character; #the character we are following

var currentVehicle = null

var velocity: Vector2
var lastPosition: Vector2

var lastOutsidePlayerPosition  #for when you go inside

var Cam
var CamRemoteTransform
var NearbyArea
var NearbyAreaRemoteTransform
var zoom = 2
var targetZoom = 2

func _ready():
	Game.connect("goInside", self, "goInside")
	Game.connect("goOutside", self, "goOutside")
	Game.connect("rideVehicle", self, "rideVehicle")
	Game.connect("newPlayerStart", self, "setPlayerStart")
	Game.player = self	
	Cam = $PlayerCamera
	Cam.global_position = body.global_position
	CamRemoteTransform = body.get_node("CamRemoteTransform2D")
	CamRemoteTransform.remote_path = Cam.get_path()
	NearbyArea = $NearbyArea
	NearbyArea.global_position = body.global_position
	NearbyAreaRemoteTransform = body.get_node("NearbyAreaRemoteTransform2D")
	NearbyAreaRemoteTransform.remote_path = NearbyArea.get_path()

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
	velocity = body.move_and_slide(velocity);
	if (abs(zoom - targetZoom) >= 0.01):
		zoom = lerp(zoom, targetZoom, 0.005);
	else: zoom = targetZoom;
	Cam.zoom.x = zoom;
	Cam.zoom.y = zoom;
	if lastPosition != position:
		Game.emit_signal("playerMoved", lastPosition.x-position.x, lastPosition.y-position.y)
		lastPosition = position		

func get_input():	
	if Game.isPaused:
		return
	if (movementEnabled): doMovement();	
	#if Input.is_action_pressed("ui_home"):
		#Map.doShow(true)
	#if Input.is_action_pressed("ui_end"):
		#Map.doShow(false)		


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

func goOutside(data):			
	if lastOutsidePlayerPosition:
		set_deferred("global_position", lastOutsidePlayerPosition)
	else:
		pass

func goInside(data):
	lastOutsidePlayerPosition = body.global_position
	remove_child(body)
	Game.InsideHouses[data.insideHouse].get_node(Game.InsideHouses[data.insideHouse].firstRoom).add_child(body)	
	body.global_position = Game.InsideHouses[data.insideHouse].get_node("PlayerStart").global_position
	
	#get the firstRoom and add player's body as a child
	
	
func setPlayerStart(newPosition):
	if !lastOutsidePlayerPosition:
		lastOutsidePlayerPosition = newPosition
	position = newPosition

func setCharacter(newCharacter):
	character = newCharacter
	position = newCharacter.position
	Game.emit_signal("goOutside", {"neighbourhood": newCharacter.bodyNeighbourhood, "street": newCharacter.bodyStreet})
	if newCharacter.bodyInside:
		Game.emit_signal("goInside", {"insideHouse": newCharacter.bodyInside})

func rideVehicle(data):	
	if data && not currentVehicle:
		data.vehicle.get_parent().remove_child(data.vehicle)
		add_child(data.vehicle)		
		data.vehicle.position = Vector2(0,0)
		if data.vehicle.vehicleType == Enums.VehicleType.Bike:
			speed = Enums.PlayerSpeed.Biking
		if data.vehicle.vehicleType == Enums.VehicleType.Car:
			speed = Enums.PlayerSpeed.Car
		currentVehicle = data.vehicle
		
func exitVehicle():	
	remove_child(currentVehicle)
	Game.CurrentStreetOrRoom.add_child(currentVehicle)	
	currentVehicle.endRiding()
	currentVehicle.global_position = global_position	
	currentVehicle = null
	speed = Enums.PlayerSpeed.Walking
					
