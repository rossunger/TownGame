extends Node2D
enum Days {Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday}
export (Days) var DayOfTheWeek = Days.Monday setget SetDayOfTheWeek
export (int, 0, 365) var DayOfTheYear = 0
onready var NPCManager = get_node(NPCManager)

func SetDayOfTheWeek(day):
	DayOfTheWeek = day	
	

