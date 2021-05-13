tool
extends AIKnowledgeItem

func _ready():
	fixedValueOptions = []
	var businessManager = load("res://BusinessManager.tscn").instance()
	for business in businessManager.get_children():
		for job in business.get_children():
			fixedValueOptions.append(job.name)
	businessManager.free()	
