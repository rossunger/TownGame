extends Reference
class_name test
enum viewMode {SIDE,MAP,MENU}

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

"""
class Relationship:
	var withWhom : NodePath
	var trust = 0
	var attraction = 0
"""
class Household:
	var Name = "New Household"
	var Houses : Array #of NodePath to house
	var Members : Array #of NodePath to character
	var AdultConstelation = 0 #_single, _straight, _queer, _poly
	var Ethnicity = [true,false,false,false,false,false,false,false,false,false,false]	
	var Religion = [0,0,0,0,0] # _Atheist, _Agnostic, _RedRoad, _Christian, _OtherReligion 
	var EnglishSecondLanguage = false
	var AnnualIncome = _35k # _100k, _60k, _35k, _21k, _11k, _6k
	var IncomeType = _LegalIncome
	var Politics = 0 # -1 =radical left, +1 = radical right	
	#var homeOwners / Renter / Homeless
	#var newMoney / OldMoney / NoMoney
	var YearsHere = 12

class House:
	var ResidentHousehold : Household
	var Landlord : Household #if different
	var Location : Vector2
	var InsideScene : NodePath #scene to load when inside the house	

class NonNPCs:
	var Name
	var Owner
	var Location
	
enum {_happiness, _sadness, _anger, _fear, _disgust, _surprise}
enum {_Single, _Straight, _Queer, _Poly}
enum {_White, _Black, _Native, _EastAsian, _SouthAsian, _MiddleEastern, _African, _European, _SouthAmerican}
enum {_Atheist, _Agnostic, _RedRoad, _Christian, _OtherReligion }
enum {_LegalIncome, _UnderTheTable, _CriminalIncome}
enum {_100k, _60k, _35k, _21k, _11k, _6k}
