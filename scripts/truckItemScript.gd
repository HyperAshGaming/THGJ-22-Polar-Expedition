extends Node3D

@onready var playerTruck = get_node("/root/TruckIntermissionScene/PlayerTruck")

var mouseEntered = false
var truckItemCounter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse1Down = playerTruck._get_mouse1Down()
	if mouse1Down == true and mouseEntered == true:
		get_parent().truckItemCounter += 1
		queue_free()

func _area_entered(_area: Area3D):
	# print(self.name)
	mouseEntered = true

func _area_exited(_area: Area3D):
	mouseEntered = false

