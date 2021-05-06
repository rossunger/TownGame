extends Resource
class_name Household

export var name = ""
export (Array, String) var Members
export (Enums.RelationshipIdentities) var RelationshipType
export (Enums.Ethnicities) var Ethnicity
export (Enums.Religions) var Religion
export (bool) var EnglishIsSecondLangauge
export (Enums.IncomeBrackets) var IncomeBracket
export (Enums.IncomeTypes) var IncomeType
export (Enums.YearsHere) var YearsHere
export (Enums.PoliticalLeanings) var politicalLeaning

#var homeOwners / Renter / Homeless

