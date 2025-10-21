extends Node3D

var y_pos = 2.25
var vL = [Vector3(92.0, y_pos, 654.0), Vector3(180.0, y_pos, 588.0), Vector3(43.0, y_pos, 755.0), Vector3(141.0, y_pos, 705.0),
		Vector3(200.0, y_pos, 775.0), Vector3(98.0, y_pos, 749.0), Vector3(155.0, y_pos, 788.0)]

@onready var flashlight = preload("res://scenes/flashlight.tscn")
@onready var map = preload("res://scenes/map.tscn")
@onready var camera = preload("res://scenes/cameraItem.tscn")
@onready var folder = preload("res://scenes/folder.tscn")
@onready var backpack = preload("res://scenes/backpack.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var itemList = [camera, backpack]
	for item in itemList:
		var itemChild = item.instantiate()
		var itemPos = randi_range(0, len(vL) - 1)
		itemChild.position = vL[itemPos]
		vL.pop_at(itemPos)
		add_child(itemChild)
	for i in range(0,3):
		var folderChild = folder.instantiate()
		var itemPos = randi_range(0, len(vL) - 1)
		folderChild.position = vL[itemPos]
		vL.pop_at(itemPos)
		add_child(folderChild)

#may move this into the main function and delete this script in the future