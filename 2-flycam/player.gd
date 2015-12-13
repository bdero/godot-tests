extends Spatial


var camera
var lastMousePos
var currentMousePos = Vector2(0, 0)

func _ready():
	camera = get_node("camera")
	set_process_input(true)
	
func _input(event):
	if event.type==InputEvent.MOUSE_MOTION:
		lastMousePos = currentMousePos
		currentMousePos = event.pos
		var diffMousePos = currentMousePos - lastMousePos
		
		set_rotation(Vector3(0, get_rotation().y + diffMousePos.x/500, 0))
		camera.set_rotation(Vector3(camera.get_rotation().x + diffMousePos.y/500, 0, 0))
	elif event.is_action_released("ui_cancel"):
		get_tree().quit()
	
func _enter_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
