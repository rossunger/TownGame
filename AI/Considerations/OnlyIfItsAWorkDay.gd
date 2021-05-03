extends Consideration

#data contains the children

func evaluate():
	score = 1	
	if not get_node("DaysIWork").get_value().has(Enums.getDayOfTheWeek(get_node("DayOfTheYear").get_value())):		
		score = 0	
	return score

func valueInArray(arr, val):
	return arr.has(val)

func valueInRange(theRange:Vector2, val):
	if val > theRange.x && val < theRange.y:
		return true
	return false
