class_name FruitNinjaSpawnPoints
extends Node2D

var spawn_points: Array

func _ready() -> void:
	spawn_points.resize(get_children().size())
	for child in get_children():
		var index = int(child.name)
		spawn_points[index] = child

func get_point_position(index: int):
	if index < spawn_points.size():
		return spawn_points[index].position

func get_point_rotation(index: int):
	if index < spawn_points.size():
		return spawn_points[index].rotation
