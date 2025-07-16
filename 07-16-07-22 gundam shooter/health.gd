class_name GundamHealth
extends Node

signal no_health

@export var _health_bar: TextureProgressBar

var max_health: int
var current_health: int:
	set(value):
		current_health = value
		_health_bar.value = value

func _ready() -> void:
	reset_health()

func damage(amount: int):
	if current_health <= 0:
		return
	current_health = clamp(current_health - amount, 0, max_health)
	if current_health <= 0:
		no_health.emit()

func heal(amount: int):
	current_health += amount

func set_max_health(amount: int):
	max_health = amount
	_health_bar.max_value = amount

func reset_health():
	current_health = max_health
