extends Node3D
@onready var player = get_node("/root/Main/Player")

var x_pos_item
var y_pos_item
var z_pos_item
var BOB_FREQ = 1.1
var BOB_AMP = 0.075
var t_bob = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	x_pos_item = transform.origin.x
	y_pos_item = transform.origin.y
	z_pos_item = transform.origin.z
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation_degrees.y += .5
	t_bob += delta
	transform.origin = _headbob(t_bob)

func _remove_self(area: Area3D):
	var mouse1Down = player._get_mouse1Down()
	if area.name == "playerArea" and mouse1Down == true:
		player._increaseItemCounter()
		queue_free()

func _headbob(time) -> Vector3:
	var pos = Vector3(x_pos_item, y_pos_item, z_pos_item)
	pos.y = sin(time * BOB_FREQ) * 10 * BOB_AMP + y_pos_item
	# pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

