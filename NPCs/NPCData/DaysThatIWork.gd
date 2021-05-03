extends Resource
class_name DaysThatIWork
export var Mon = true 
export var Tue = true 
export var Wed = true 
export var Thu = true 
export var Fri = true 
export var Sat = false
export var Sun = false
func getDaysThatIWork(val):	
	var arr = []
	if Mon:
		arr.append(0)
	if Tue:
		arr.append(1)
	if Wed:
		arr.append(2)
	if Thu:
		arr.append(3)
	if Fri:
		arr.append(4)
	if Sat:
		arr.append(5)
	if Sun:
		arr.append(6)
	return arr
