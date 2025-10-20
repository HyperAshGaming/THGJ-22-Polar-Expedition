extends CharacterBody3D

@onready var nav_agent = $enemyNavAgent
@onready var player = get_node("/root/Main/Player")
@onready var main = get_node("/root/Main")
@onready var lookHands = $lookNode
@onready var raycast = $visionRaycast
@onready var visionArea = $VisionArea

var SPEED = 7.5
var newTargetAllowed = true
var wanderActive = false

var radius = 1
# var mouse1Down = false

var positionList = [Vector3(46.0, 0.0, 744.0), Vector3(131.0, 0.0, 744.0), Vector3(66.0, 0.0, 816.0), Vector3(102.0, 0.0, 682.0), Vector3(100.0, 0.0, 733.0)]

func _ready() -> void:
	transform.origin = positionList.pick_random()
	#print("ready! --------------")

func _physics_process(_delta):
	var overlaps = visionArea.get_overlapping_areas()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "playerArea":
				var playerPosition = overlap.global_transform.origin
				raycast.target_position = to_local(playerPosition)
				raycast.force_raycast_update()
				if raycast.is_colliding():
					var collider = raycast.get_collider()
					if collider.name == "playerArea":
						update_target(player.transform.origin)
						#print("chasing")
						newTargetAllowed = false
					elif collider.name != "playerArea":
						if newTargetAllowed == true:
							#print("wandering")
							newTargetAllowed = null
						elif newTargetAllowed == false:
							#print("calling ===============================================================")
							checkIfNewTarget()
						else:
							if wanderActive == false:
								wanderActive = true
								_wander()
	
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity
	#print(nav_agent.target_position, wanderActive, "++++")
	# update_target(Vector3(66.0, 0.0, 816.0))
	look_at(player.transform.origin, Vector3.UP)
	#print(newTargetAllowed, "===============================================================")
	move_and_slide()
	
func checkIfNewTarget():
	#print("Wait! ===============================================================")
	await get_tree().create_timer(6.0).timeout
	#print("Go! ===============================================================")
	newTargetAllowed = true

func enemy_wander(wander_location):
	# SPEED = 100.0
	nav_agent.target_position = wander_location

func update_target(target_location):
	#print("update")
	nav_agent.target_position = target_location

func _reached_target():
	#print("target reached")
	wanderActive = false
	newTargetAllowed = true

func _player_area_entered(area: Area3D) -> void:
	#print(area.name)
	var mouse1Down = player._get_mouse1Down()
	#print(mouse1Down)
	if area.name == "playerArea" and mouse1Down == true:
		#print("deleteing")
		main._spawn_enemy()
		queue_free()

func _wander():
	update_target(positionList.pick_random())

#when sees player, disallows wander until player is out of sight again + 2 seconds
#wander goes to random position on map
#chasing increases speed from 7.5 -> 12.5