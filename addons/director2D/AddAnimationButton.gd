tool
extends Button

func buttonPressed():		
	var animPath = "res://Timelines/Animations/" + get_node("../NewAnimationName").text + ".tres"
	if not ResourceLoader.exists(animPath):		
		get_owner().createAnimationButtonPressed(get_node("../NewAnimationName").text)
		get_node("../ErrorLabel").visible = false
	else:				
		get_node("../ErrorLabel").visible = true	
	
