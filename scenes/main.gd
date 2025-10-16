extends Node3D

@onready var enemy = preload("res://scenes/cave_enemy.tscn")

func _ready():
    # var player = get_children()[0]
	for i in range(1,5,1):
		var enemyChild = enemy.instantiate()
		await get_tree().create_timer(1.5).timeout
		add_child(enemyChild)

# func enemyFunc(_camera: Node, _event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int):
#     print("test")

#     print("got got")
