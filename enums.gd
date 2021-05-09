extends Node

static func getDayOfTheWeek(day: int):
	return day % 7
	
static func getDateOfTheYear(day: int):
	if day <= 31:
		return str(day) + " Jan"
	if day <= 31+29:
		return str(day-31) + " Feb"
	if day <= 31+29+31:
		return str(day-31-29) + " Mar"
	if day <= 31+29+31+30:
		return str(day-31-29-31) + " Apr"
	if day <= 31+29+31+30+31:
		return str(day-31-29-31-30) + " May"
	if day <= 31+29+31+30+31+30:
		return str(day-31-29-31-30-31) + " Jun"
	if day <= 31+29+31+30+31+30+31:
		return str(day-31-29-31-30-31-30) + " Jul"
	if day <= 31+29+31+30+31+30+31+31:
		return str(day-31-29-31-30-31-30-31) + " Aug"
	if day <= 31+29+31+30+31+30+31+31+30:
		return str(day-31-29-31-30-31-30-31-31) + " Sep"
	if day <= 31+29+31+30+31+30+31+31+30+31:
		return str(day-31-29-31-30-31-30-31-31-30) + " Oct"
	if day <= 31+29+31+30+31+30+31+31+30+31+30:
		return str(day-31-29-31-30-31-30-31-31-30-31) + " Nov"
	if day <= 31+29+31+30+31+30+31+31+30+31+30+31:
		return str(day-31-29-31-30-31-30-31-31-30-31-30) + " Dec"
	
enum viewMode {SIDE,MAP,MENU}

enum DaysOfTheWeek {Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday}
enum TimesOfDay {Morning, Afternoon, Evening, Night}

enum Emotions {_happiness, _sadness, _anger, _fear, _disgust, _surprise}

#HOUSEHOLD STUFF
enum RelationshipIdentities {Single, Straight, Queer, Poly}
enum Ethnicities {White, Black, Native, EastAsian, SouthAsian, MiddleEastern, African, European, SouthAmerican}
enum Religions {Atheist, Agnostic, RedRoad, Christian, OtherReligion }
enum IncomeTypes {LegalIncome, UnderTheTable, CriminalIncome}
enum IncomeBrackets {_100k, _60k, _35k, _21k, _11k, _6k}
enum YearsHere {bornAndBred, _20, _12, _5, justArrived}
enum PoliticalLeanings { centre, radicalLeft, left,  right, radicalRight }
enum WealthType { noMoney, newMoney, oldMoney }
enum HomeOwnership { homeOwners, renters, homeless }

enum PlayerSpeed {Walking=300, Running=450, Biking=600, Car=800}

enum VehicleType {Bike, Car}

enum Layers {OutsideSolid = 0, OutsideInteractable = 1, OutsideArea = 2, InsideSolid = 5, InsideInteractable = 6, InsideArea=7}
