extends Node2D
var endThread=false
var AIThread 
const _Delay = 1000 #how often to update the AI thread
#Set the AI thread to process every 
func _ready():
	AIThread = Thread.new()
	AIThread.start(self, "AITick")
	
func AITick(args):
	if endThread:
		return
	get_tree().call_group("AI", "ai_tick")
	OS.delay_msec(_Delay)	
	AITick(args)

func _exit_tree():
	endThread=true
	AIThread.wait_to_finish()
