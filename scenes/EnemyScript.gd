extends CharacterBody3D

@onready var nav_agent = $enemyNavAgent
@onready var player = get_node("/root/Main/Player")
@onready var main = get_node("/root/Main")
@onready var lookHands = $lookNode
@onready var raycast = $visionRaycast

var SPEED = 7.5
var NewTargetAllowed = true

var radius = 1
# var mouse1Down = false

var positionList = [Vector3(46.0, 7.0, 744.0), Vector3(131.0, 7.0, 744.0), Vector3(66.0, 7.0, 835.0), Vector3(102.0, 7.0, 682.0), Vector3(100.0, 7.0, 733.0)]

func _ready() -> void:
	transform.origin = positionList.pick_random()
	print("ready!")

func _physics_process(_delta):
	
	# SPEED = 100.0
	# print(player.transform.origin , " ", self.transform.origin, " ", nav_agent.target_position)
	raycast.target_position = player.transform.origin
	print(raycast.target_position, " ", player.global_transform.origin, " ", player.transform.origin)
	raycast.look_at(-player.transform.origin)
	raycast.force_raycast_update()
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.name == "Player":
			print("chasing")
		else:
			print(collider.name, " not player")
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity
	update_target_player(player.transform.origin)
	lookHands.look_at(player.transform.origin, Vector3.UP)
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

func _player_area_entered(area: Area3D) -> void:
	print(area.name)
	var mouse1Down = player._get_mouse1Down()
	print(mouse1Down)
	if area.name == "playerArea" and mouse1Down == true:
		print("deleteing")
		main._spawn_enemy()
		queue_free()
