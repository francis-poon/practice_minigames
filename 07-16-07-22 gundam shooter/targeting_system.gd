class_name GundamTargetingSystem
extends Node2D

signal target_position(position: Vector2, hit_targets: Array[GundamEnemy])

@export var target_indicator: Sprite2D
@export var lead_indicator: Sprite2D
@export var target_area: Area2D

@export var move_speed: float = 30

var is_running: bool

func _ready() -> void:
	disable()

func _process(delta: float) -> void:
	# lead indicator will move towards mouse while target indicator will move toward lead
	# lead indicator will not move more than max_distance away from target
	if not is_running:
		return
	
	var target: Vector2 = get_global_mouse_position()
	lead_indicator.global_position = target
	if target_indicator.position.distance_to(target) > 1:
		target_indicator.global_position = target_indicator.global_position.move_toward(target, move_speed * delta)

func _input(event: InputEvent) -> void:
	if not is_running:
		return
	
	if event is InputEventMouseButton \
	and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var hit_targets: Array[GundamEnemy] = []
		for target in target_area.get_overlapping_bodies():
			if target is GundamEnemy:
				hit_targets.append(target)
		target_position.emit(target_indicator.global_position, hit_targets)

func disable():
	is_running = false
	hide()

func enable():
	is_running = true
	show()
