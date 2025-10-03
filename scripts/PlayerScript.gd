extends CharacterBody3D


const SPEED = 5
const JUMP_VELOCITY = 4.5

const SENSITIVITY = .00075;

var BOB_FREQ = 1.1
var BOB_AMP = 0.075
var t_bob = 0.0

@onready var Neck = $Neck
@onready var Camera = $Neck/Camera
@onready var snowStep1 = $SoundEffects/snowStep1
@onready var snowStep2 = $SoundEffects/snowStep2
@onready var snowStep3 = $SoundEffects/snowStep3
var snowList = []
var snowIteration = 0
var footstepAllow = true

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			self.rotate_y(-event.relative.x * SENSITIVITY)
			Camera.rotate_x(-event.relative.y * SENSITIVITY)
			Camera.rotation.x = clamp(Camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	snowList = [snowStep1, snowStep2, snowStep3]
	for sound in snowList:
		sound.pitch_scale = 1.0

func _physics_process(delta):
	# SoundsPlaylist.stream_count[0].play()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("a", "d", "w", "s")
	var direction = (self.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if footstepAllow == true:
			_snowFootsteps()

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

func _snowFootsteps():
	if snowIteration > 2:
		snowIteration = 0
	snowList[snowIteration].play()
	snowIteration += 1
	footstepAllow = false
	await get_tree().create_timer(0.75).timeout
	footstepAllow = true


func _change_to_snow_steps(body: Node3D):
	if body.name == "Player":
		for sound in snowList:
			sound.pitch_scale = 1.0

func _change_to_ice_steps(body: Node3D):
	if body.name == "Player":
		for sound in snowList:
			sound.pitch_scale = 3.0

#git reset --hard HEAD
#git pull

