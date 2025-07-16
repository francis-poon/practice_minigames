class_name GundamEnemy
extends CharacterBody2D

signal attack(dmg_val: int)

@export var max_health: int = 1
@export var approach_time: float = 6
@export var attack_time: float = 4
@export var dmg_val: int = 1
@export var start_scale: float = 1
@export var end_scale: float = 4
@export var move_probability: float = 0.5

@export var _approach_timer: Timer
@export var _attack_timer: Timer
@export var _attack_progress: ProgressBar
@export var _collision_shape: CollisionShape2D

var current_health: int


func _ready():
	current_health = max_health
	_approach_timer.wait_time = approach_time
	_approach_timer.timeout.connect(_on_approach_timer)
	_approach_timer.one_shot = true
	_attack_timer.wait_time = attack_time
	_attack_timer.timeout.connect(_on_attack_timer)
	_attack_timer.one_shot = false
	_attack_progress.hide()
	
	scale = Vector2(start_scale, start_scale)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "scale", Vector2(end_scale, end_scale), approach_time)
	_approach_timer.start()
	GundamGameEvents.game_tick.connect(_on_game_tick)

func _physics_process(delta: float) -> void:
	move_and_slide()

func move_rand():
	velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * 100
	await get_tree().create_timer(0.5).timeout
	velocity = Vector2.ZERO

func damage(dmg_val: int):
	current_health -= dmg_val
	if current_health <= 0:
		die()

func die():
	GundamGameEvents.emit_add_points(1)
	queue_free()

func get_rect():
	var rect: Rect2 = _collision_shape.shape.get_rect()
	rect.position = get_global_transform_with_canvas().origin
	
	return rect

func _on_game_tick():
	if randf() < move_probability:
		move_rand()

func _on_approach_timer():
	_attack_progress.show()
	_attack_progress.value = _attack_progress.min_value
	get_tree().create_tween().parallel().tween_property(_attack_progress, "value", _attack_progress.max_value, attack_time)
	_attack_timer.start()

func _on_attack_timer():
	attack.emit(dmg_val)
	_attack_progress.value = _attack_progress.min_value
	get_tree().create_tween().parallel().tween_property(_attack_progress, "value", _attack_progress.max_value, attack_time)
