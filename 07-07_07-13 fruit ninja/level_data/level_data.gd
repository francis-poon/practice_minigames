class_name LevelData
extends Resource

@export var spawn_point_order: Array[int]
@export var spawn_delay: Array[float]
@export var target_order: Array[int]


func _init(p_spawn_point_order: Array[int] = [], p_spawn_delay: Array[float] = [], p_target_order: Array[int] = []):
	spawn_point_order = p_spawn_point_order
	spawn_delay = p_spawn_delay
	target_order = p_target_order
