extends Area2D

"""
func _physics_process(delta):
	var overlaps = get_overlapping_areas()
	var parent = get_parent()
	if overlaps.size() == 0:
		z_index = 0
	for o in overlaps:
		var oParent = o.get_parent()
		if oParent.global_position.y > parent.global_position.y:
			oParent.z_index = parent.z_index + 1
			print(oParent.z_index)
		else:
			parent.z_index = oParent.z_index + 1
			print(oParent.z_index)
		

"""
