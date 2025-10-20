extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _remove_self(_camera: Node, _event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int):
	if Input.is_action_just_pressed("mouse1"):
		queue_free()


func _on_area_3d_area_entered(area: Area3D):
	print(area)
