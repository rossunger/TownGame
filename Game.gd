extends Node2D
enum Days {Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday}
export (Days) var DayOfTheWeek = Days.Monday setget SetDayOfTheWeek
export (int, 0, 365) var DayOfTheYear = 0
onready var NPCManager = get_node("NPCManager")
var lastStreet: NodePath
var lastLocation: Vector2

func SetDayOfTheWeek(day):
	DayOfTheWeek = day	
	
func goInside(path):	
	lastLocation = $Player.position
	get_node("Inside").CurrentHouse = path	
	lastStreet = get_node("Outside").CurrentStreet
	get_node("Outside").CurrentStreet = null		

func goOutside(path):
	get_node("Outside").CurrentStreet = path
	get_node("Inside").CurrentHouse = null
	lastStreet = ""		
	$Player.position = lastLocation		
	
	
func _ready():
	goInside("/root/Game/Inside/1MainSt")
	goOutside("/root/Game/Outside/MainSt")	
