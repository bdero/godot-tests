extends KinematicBody


const SPEED = 5
const GRAVITY = -9.8

var camera
var lastMousePos
var currentMousePos = Vector2(0, 0)

var destinationRotation = Vector2(0, 0)
var currentRotation = Vector2(0, 0)

var velocity = Vector3(0, 0, 0)

func _ready():
	camera = get_node("camera")
	set_process_input(true)
	set_process(true)
	set_fixed_process(true)
	
func _process(delta):
	var diffRotation = (destinationRotation - currentRotation)*15*delta
	currentRotation += diffRotation
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
		
func _fixed_process(delta):
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
		
	velocity.x = transX*SPEED
	velocity.z = transZ*SPEED
	velocity.y += GRAVITY*delta
	
	var motion = velocity.rotated(Vector3(0, -1, 0), get_rotation().y)*delta
	motion = move(motion)
	
	var attempts = 4
	
	while(is_colliding() and attempts > 0):
		var norm = get_collision_normal()
		motion = norm.slide(motion)
		velocity = norm.slide(velocity)
		motion = move(motion)
		
		if motion.length() < 0.001:
			break
			
		attempts -= 1
	
func _enter_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
