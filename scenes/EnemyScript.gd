extends CharacterBody3D

@onready var nav_agent = $enemyNavAgent
@onready var player = get_node("/root/Main/Player")

var SPEED = 5.0
var NewTargetAllowed = true

var radius = 1

func _physics_process(_delta):
	# print(player.transform.origin , " ", self.transform.origin, " ", nav_agent.target_position)
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity
	update_target_player(player.transform.origin)
	move_and_slide()
	
func enemy_wander(wander_location):
	nav_agent.target_position = wander_location

func update_target_player(target_location):
	# nav_agent.target_position = Vector3(target_location.x, 100.0, target_location.y)
	nav_agent.target_position = target_location
	# pass
