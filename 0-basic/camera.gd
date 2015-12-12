extends Spatial


var speed = Vector3(0, 2.5, 0)

func _ready():
	set_process(true)
	
func _process(delta):
	set_rotation(get_rotation() + speed*delta)