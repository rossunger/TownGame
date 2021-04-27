tool
extends EditorPlugin

var dock

func _enter_tree():
	dock = preload("res://addons/director2D/director.tscn").instance()
	add_control_to_dock(DOCK_SLOT_LEFT_UR, dock)
	pass
	
func _exit_tree():
	remove_control_from_docks(dock)   
	dock.free()
	pass

