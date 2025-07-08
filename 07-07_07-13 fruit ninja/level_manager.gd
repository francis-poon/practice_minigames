class_name FruitNinjaLevelManager
extends Node

signal level_failed
signal level_complete
signal all_levels_complete

@export var level_list: Array[LevelData]

@export var fruit_scene: PackedScene
@export var spawn_points: FruitNinjaSpawnPoints
@export var launch_impulse: float = -350 

var current_level_index: int
var fruit_bar: Array
var current_target_index: int

func _ready() -> void:
	_reset_game_vars()

func new_game():
	_reset_game_vars()
	start_level()

func start_level():
	_reset_level_vars()
	var current_level: LevelData = level_list[current_level_index]
	fruit_bar.resize(current_level.spawn_point_order.size())
	
	# Spawn every fruit in position so that they can be targeted
	for i in range(current_level.spawn_point_order.size()):
		var spawn_point_idx = current_level.spawn_point_order[i]
		fruit_bar[i] = fruit_scene.instantiate()
		fruit_bar[i].position = spawn_points.get_point_position(spawn_point_idx)
		add_child(fruit_bar[i])
	
	# Target first fruit as designated by target order
	if current_level.target_order.size() == 0:
		fruit_bar[0].target()
	else:
		fruit_bar[current_level.target_order[0]].target()
	for i in range(current_level.spawn_point_order.size()):
		var fruit: SliceableFruit = fruit_bar[i]
		var spawn_point_idx = current_level.spawn_point_order[i]
		
		fruit.fruit_expired.connect(_on_fruit_expired)
		fruit.launch(spawn_points.get_point_rotation(spawn_point_idx), launch_impulse)
		#print(current_level.spawn_delay[spawn_point_idx])
		if current_level.spawn_delay[i] > 0:
			await get_tree().create_timer(current_level.spawn_delay[i]).timeout

func slice(slice_direction: SliceableFruit.SliceDirection):
	var current_level: LevelData = level_list[current_level_index]
	if current_level.target_order.size() == 0 and fruit_bar[current_target_index].slice(slice_direction) or \
	current_target_index < current_level.target_order.size() and \
	fruit_bar[current_level.target_order[current_target_index]].slice(slice_direction):
		current_target_index += 1
		if current_target_index >= current_level.spawn_point_order.size():
			current_level_index += 1
			if current_level_index >= level_list.size():
				all_levels_complete.emit()
			else:
				level_complete.emit()
		else:
			if current_level.target_order.size() == 0:
				fruit_bar[current_target_index].target()
			else:
				fruit_bar[current_level.target_order[current_target_index]].target()

func _reset_game_vars():
	current_level_index = 0
	fruit_bar = []
	current_target_index = 0

func _reset_level_vars():
	current_target_index = 0

func _on_fruit_expired():
	level_failed.emit()
