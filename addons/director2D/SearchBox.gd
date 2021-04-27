tool
extends LineEdit

signal doSearch

func _on_SearchBox_text_entered(new_text):
	emit_signal("doSearch", new_text)

func _on_SearchBox_focus_entered():
	if text == "Search":
		text = ""


func _on_SearchBox_focus_exited():
	if text == "":
		text = "Search"
