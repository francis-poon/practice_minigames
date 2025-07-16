extends Node

@export var spawn_area: CollisionShape2D
@export var enemy: PackedScene

@export var _spawn_timer: Timer
@export var _enemies: Node

var is_running: bool

func _ready() -> void:
	is_running = false
	GundamGameEvents.new_game.connect(_on_new_game)
	GundamGameEvents.game_over.connect(_on_game_over)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("apply_force"):
		_spawn_random()

func _on_new_game():
	is_running = true
	_spawn_timer.start()

func _on_game_over():
	is_running = false
	_spawn_timer.stop()
	for child in _enemies.get_children():
		child.queue_free()

func _spawn_random():
	var spawn_rect: Rect2 = spawn_area.shape.get_rect()
	var rand_x = randf_range(spawn_rect.position.x, spawn_rect.position.x + spawn_rect.size.x)
	var rand_y = randf_range(spawn_rect.position.y, spawn_rect.position.y + spawn_rect.size.y)
	
	var new_enemy: GundamEnemy = enemy.instantiate()
	new_enemy.position = Vector2(rand_x, rand_y)
	new_enemy.attack.connect(_on_attack)
	_enemies.add_child(new_enemy)


func _on_timer_timeout() -> void:
	if not is_running:
		return
	_spawn_random()

func _on_attack(dmg_val: int):
	GundamGameEvents.emit_player_damaged(dmg_val)
