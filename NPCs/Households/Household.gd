extends Node
class_name Household

export (String) var neighbourhood
export (String) var street
export (String) var address
export (Array, String) var members
export (Enums.RelationshipIdentities) var relationshipType
export (Enums.Ethnicities) var ethnicity
export (Enums.Religions) var religion
export (bool) var englishIsSecondLangauge
export (Enums.IncomeBrackets) var incomeBracket
export (Enums.IncomeTypes) var incomeType
export (Enums.YearsHere) var yearsHere
export (Enums.PoliticalLeanings) var politicalLeaning
var outsideHouse

func _ready():
	outsideHouse = Game.getStreet(neighbourhood, street).get_node(address)
	var householdLabel = get_parent().householdLabel.instance()
	householdLabel.text = name
	outsideHouse.add_child(householdLabel)
	pass
