extends CharacterBody3D

@onready var nav_agent = $enemyNavAgent
@onready var player = get_node("/root/Main/Player")

var SPEED = 7.5
var NewTargetAllowed = true

var radius = 1

func _ready() -> void:
	get_parent().transform.origin = Vector3(131.0, 7.0, 744.0)
	print("ready!")

func _physics_process(_delta):
	
	# SPEED = 100.0
	# print(player.transform.origin , " ", self.transform.origin, " ", nav_agent.target_position)
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity
	update_target_player(player.transform.origin)
	# print(nav_agent.target_position, player.transform.origin, transform.origin)
	# set_navigation_map
	move_and_slide()
	
func enemy_wander(wander_location):
	# SPEED = 100.0
	nav_agent.target_position = wander_location

func update_target_player(target_location):
	# nav_agent.target_position = Vector3(target_location.x, 100.0, target_location.y)
	nav_agent.target_position = target_location
	# self.get_current_navigation_path()
	# pass


func _reached_target():
	# SPEED = 50.0
	print("target reached")


func _player_click(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	queue_free()