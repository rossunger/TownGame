extends Sprite

onready var animPlayer: AnimationPlayer = get_node("AnimationPlayer");

func doShow(show):	
	animPlayer.play("GoToMap") if show else animPlayer.play_backwards("GoToMap") 
