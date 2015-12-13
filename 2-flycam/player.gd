extends Spatial


const SPEED = 5

var camera
var lastMousePos
var currentMousePos = Vector2(0, 0)

var destinationRotation = Vector2(0, 0)
var currentRotation = Vector2(0, 0)

func _ready():
	camera = get_node("camera")
	set_process_input(true)
	set_process(true)
	
func _process(delta):
	movement(delta)
	
	currentRotation += (destinationRotation - currentRotation)*15*delta
	
	set_rotation(Vector3(0, currentRotation.x, 0))
	camera.set_rotation(Vector3(currentRotation.y, 0, 0))
	
func _input(event):
	if event.type==InputEvent.MOUSE_MOTION:
		# Handle player rotation
		lastMousePos = currentMousePos
		currentMousePos = event.pos
		
		var diffMousePos = currentMousePos - lastMousePos
		destinationRotation -= diffMousePos/500
	elif event.is_action_released("ui_cancel"):
		get_tree().quit()
		
func movement(delta):
	var transX = 0
	var transZ = 0
	
	if Input.is_action_pressed("ui_up"):
		transZ -= 1
	if Input.is_action_pressed("ui_down"):
		transZ += 1
	
	if Input.is_action_pressed("ui_left"):
		transX -= 1
	if Input.is_action_pressed("ui_right"):
		transX += 1
	
	var translation = Vector3(transX, 0, transZ).rotated(Vector3(0, -1, 0), currentRotation.x)
	
	set_translation(get_translation() + translation*SPEED*delta)
	
func _enter_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
