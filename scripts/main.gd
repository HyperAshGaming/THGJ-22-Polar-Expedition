extends Node3D

@onready var enemy = preload("res://scenes/cave_enemy.tscn")

func _ready():
    # var player = get_children()[0]
	# _spawn_enemy()
	pass

func _spawn_enemy():
	var enemyChild = enemy.instantiate()
	await get_tree().create_timer(randi_range(2,5)).timeout
	add_child(enemyChild)
