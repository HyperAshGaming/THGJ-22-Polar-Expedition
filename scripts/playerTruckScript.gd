extends CharacterBody3D


var SPEED = 5
const JUMP_VELOCITY = 4.5

const SENSITIVITY = .00075;

var BOB_FREQ = 1.1
var BOB_AMP = 0.075
var t_bob = 0.0

@onready var Neck = $Neck
@onready var Camera = $Neck/Camera
@onready var metalFootstep 
var snowList = []
var snowIteration = 0
var footstepAllow = true

var mouse1Down = false

var itemCounter = 0

func _unhandled_input(event):
	# print(get_viewport().debug_draw)
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			self.rotate_y(-event.relative.x * SENSITIVITY)
			Camera.rotate_x(-event.relative.y * SENSITIVITY)
			Camera.rotation.x = clamp(Camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	
	if event.is_action_pressed("run"):
		SPEED = 15;
	elif event.is_action_released("run"):
		SPEED = 5;
	
	if event.is_action_pressed("mouse1"):
		mouse1Down = true
	elif event.is_action_released("mouse1"):
		mouse1Down = false

func _ready():
	# get_viewport().debug_draw = Viewport.DEBUG_DRAW_DISABLED
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# SoundsPlaylist.stream_count[0].play()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("a", "d", "w", "s")
	var direction = (self.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if footstepAllow == true:
			_truckFootsteps()

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	Neck.transform.origin = _headbob(t_bob)
	move_and_slide()

	return BOB_AMP

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

func _get_mouse1Down():
	return mouse1Down

func _truckFootsteps():
	pass
	# metalFootstep.play()
	# footstepAllow = false
	# await get_tree().create_timer(0.75).timeout
	# footstepAllow = true
