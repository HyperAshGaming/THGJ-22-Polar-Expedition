extends Node3D
@onready var player = get_node("/root/Main/Player")

var x_pos_item
var y_pos_item
var z_pos_item
var BOB_FREQ = 1.1
var BOB_AMP = 0.075
var t_bob = 0.0
var lookingAt = false
# Called when the node enters the scene tree for the first time.
func _ready():
	x_pos_item = transform.origin.x
	y_pos_item = transform.origin.y
	z_pos_item = transform.origin.z

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation_degrees.y += .5
	t_bob += delta
	transform.origin = _headbob(t_bob)
	if lookingAt == true:
		var mouse1Down = player._get_mouse1Down()
		if mouse1Down == true:
			player._increaseItemCounter()
			queue_free()
		

func _area_entered(area: Area3D):
	if area.name == "playerArea":
		lookingAt = true
	
func _area_exited(area: Area3D) -> void:
	if area.name == "player":
		lookingAt = false

func _headbob(time) -> Vector3:
	var pos = Vector3(x_pos_item, y_pos_item, z_pos_item)
	pos.y = sin(time * BOB_FREQ) * 10 * BOB_AMP + y_pos_item
	# pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos



func _remove_self_test(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	var mouse1Down = player._get_mouse1Down()




# func _area_exited(area: Area3D) -> void:
# 	pass # Replace with function body.
# 	print("test")
# 	if mouse1Down == true:
# 		player._increaseItemCounter()
# 		queue_free()
