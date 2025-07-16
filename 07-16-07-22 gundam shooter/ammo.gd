class_name GundamAmmo
extends Node

@export var ammo_size: int = 10
@export var reload_time: float = 1
@export var _ammo_bar_left: TextureProgressBar
@export var _ammo_bar_right: TextureProgressBar

var reloading: bool

var current_ammo: int:
	set(value):
		current_ammo = value
		_ammo_bar_left.value = value
		_ammo_bar_right.value = value

func _ready() -> void:
	_ammo_bar_left.max_value = ammo_size
	_ammo_bar_right.max_value = ammo_size
	current_ammo = ammo_size

func new_game():
	reloading = false
	current_ammo = ammo_size

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reload"):
		reloading = true
		current_ammo = 0
		var tween = get_tree().create_tween().tween_property(self, "current_ammo", ammo_size, reload_time)
		await tween.finished
		reloading = false

func has_ammo(count: int) -> bool:
	return current_ammo >= count

func use_ammo(count: int) -> bool:
	if not has_ammo(count) or reloading:
		return false
	current_ammo -= count
	return true
