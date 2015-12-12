extends Particles


var time = 0

func _ready():
	set_process(true)
	
func _process(delta):
	time += delta
	set_translation(Vector3(0, sin(time*5)*3, 0))