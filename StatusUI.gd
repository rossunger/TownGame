extends Node

func _ready():
	Game.connect("setTimeOfDay", self, "setTimeOfDay")
	Game.connect("setDayOfTheYear", self, "setDayOfTheYear")
	setDayOfTheYear()
	Game.connect("goOutside", self, "setLocation")
	
func setTimeOfDay(timeOfDay):
	get_node("TimeOfDay").text = Enums.TimesOfDay.keys()[timeOfDay]

func setDayOfTheYear():
	get_node("DayOfTheYearLabel").text = "Day " + str(Game.dayOfTheYear)
	get_node("DayOfTheWeekLabel").text = Enums.DaysOfTheWeek.keys()[Enums.getDayOfTheWeek(Game.dayOfTheYear)]
	get_node("DateOfTheYearLabel").text = Enums.getDateOfTheYear(Game.dayOfTheYear)

func setLocation(data):
	$Location.text = Game.player.bodyNeighbourhood
