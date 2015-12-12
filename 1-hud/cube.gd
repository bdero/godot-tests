extends TestCube


var speed = Vector3(0.5, 0.75, 0.8)

func _ready():
	set_process(true)
	
func _process(delta):
	set_rotation(get_rotation() + speed*delta)
