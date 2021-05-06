extends Reference

static func normalise(params = []):
	var sum = 0
	for i in params:
		sum += i * i
	sum = sqrt(sum)
	for i in params:
		i = i/sum	

static func largestValue(params = []):
	var largest = params[0]
	for i in params:
		if i > largest:
			largest = i 
	return largest

static func largestKeyDictionary(d = {}):
	var largest = 0
	var largestIndex = 0;
	for i in d.size():
		if d.values()[i] > largest:
			largestIndex = i
	return d.keys()[largestIndex]

static func smallestValue(params = []):
	var smallest = params[0]
	for i in params:
		if i < smallest:
			smallest = i 
	return smallest

