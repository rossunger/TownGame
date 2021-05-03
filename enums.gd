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
enum RelationshipIdentities {_Single, _Straight, _Queer, _Poly}
enum Ethnicities {_White, _Black, _Native, _EastAsian, _SouthAsian, _MiddleEastern, _African, _European, _SouthAmerican}
enum Religions {_Atheist, _Agnostic, _RedRoad, _Christian, _OtherReligion }
enum IncomeTypes {_LegalIncome, _UnderTheTable, _CriminalIncome}
enum IncomeBrackets {_100k, _60k, _35k, _21k, _11k, _6k}
