extends Node3D

@onready var truckAnimations = $TruckAnimations
var truckItemCounter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2.5).timeout
	truckAnimations.play("itemsOutAnimation")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# print(truckItemCounter)
	pass
	# if truckItemCounter == 2:
		# allowPlayerReadInstructions
	# if intructionsRead == true:
		# wait 10 seconds
		# make text notify player that destination has been reached
		# allowPlayerLeaveTruck
	# if playerLeaveTruck == true:
		# changeSceneToMain