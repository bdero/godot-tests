extends Node2D


var time = 0

func _ready():
	set_process(true)
	
func _process(delta):
	time += delta
	set_rot(sin(time*3)/5)