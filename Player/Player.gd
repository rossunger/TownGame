extends KinematicBody2D
class_name Player

export (int) var speed = 300
export (bool) var movementEnabled = true;
export(Enums.viewMode) var view_mode = 0;
export(NodePath) var character; #the character we are following

var velocity = Vector2()
var lastPosition: Vector2 #track this for the parallax effect... pass this info to "Outside" node.

var lastOutsidePlayerPosition  #for when you go inside

onready var Cam = get_node("Camera2D");
var zoom = 2
var targetZoom = 2

func _ready():
	Game.connect("goInside", self, "goInside")
	Game.connect("goOutside", self, "goOutside")
	Game.connect("newPlayerStart", self, "setPlayerStart")

func get_input():
	if (movementEnabled): doMovement();
	if Input.is_action_pressed("ui_select"):		
		Game.doInteraction()
	#if Input.is_action_pressed("ui_home"):
		#Map.doShow(true)
	#if Input.is_action_pressed("ui_end"):
		#Map.doShow(false)		

func _physics_process(delta):	
	get_input();
	velocity = move_and_slide(velocity);
	if (abs(zoom - targetZoom) >= 0.01):
		zoom = lerp(zoom, targetZoom, 0.005);
	else: zoom = targetZoom;
	Cam.zoom.x = zoom;
	Cam.zoom.y = zoom;
	if lastPosition != position:
		Game.emit_signal("playerMoved", lastPosition.x-position.x, lastPosition.y-position.y)
		lastPosition = position		

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

func goOutside():	
	if lastOutsidePlayerPosition:
		position = lastOutsidePlayerPosition
	else:
		pass
func goInside():
	lastOutsidePlayerPosition = position	

func setPlayerStart(newPosition):
	lastOutsidePlayerPosition = newPosition
	position = newPosition
