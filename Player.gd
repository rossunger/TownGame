extends KinematicBody2D

export (int) var speed = 300
export (bool) var movementEnabled = true;

enum viewMode {SIDE,MAP,MENU}
export(viewMode) var view_mode = 0;

var characters = {"jody": "test", "aja":"boop"}
export(NodePath) var character;

var velocity = Vector2()
var zoom = 1
var targetZoom = 1
onready var Map = get_tree().get_root().get_node("Game/Map");
onready var Cam = get_node("Camera2D");

func get_input():
	if (movementEnabled): doMovement();
		
	if Input.is_action_pressed("ui_home"):
		Map.doShow(true)
	if Input.is_action_pressed("ui_end"):
		Map.doShow(false)
		
	#if Input.is_action_pressed("ui_page_down"):
		

func _physics_process(delta):
	get_input();
	velocity = move_and_slide(velocity);
	if (abs(zoom - targetZoom) >= 0.01):
		zoom = lerp(zoom, targetZoom, 0.005);
	else: zoom = targetZoom;
	Cam.zoom.x = zoom;
	Cam.zoom.y = zoom;

func _on_Area2D_area_entered(area):	
#	area.get_parent().playNextTimeline();		
	pass

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
		targetZoom = 1.5
	else:
		targetZoom = 1		

func goInside(path):	
	get_node("/root/Game/Inside").CurrentHouse = path
	get_node("/root/Game/Outside").CurrentStreet = null	

func goOutside(path):
	get_node("/root/Game/Outside").CurrentStreet = path
	get_node("/root/Game/Inside").CurrentHouse = null
