class_name GundamPlayer
extends Node

signal player_died

@export var sprite_texture: Texture
@export var max_health: float

@export var _health: GundamHealth
@export var _targeting_system: GundamTargetingSystem
@export var _beam_rifle: GundamBeamRifle

var is_running: bool

func _ready() -> void:
	is_running = false
	GundamGameEvents.new_game.connect(_on_new_game)
	GundamGameEvents.game_over.connect(_on_game_over)
	GundamGameEvents.player_damaged.connect(_on_player_damaged)
	_health.no_health.connect(_on_no_health)


func damage(dmg_val: int):
	print("Player took {0} damage".format([dmg_val]))

func _on_targeting_target_position(position: Vector2, hit_targets: Array[GundamEnemy]) -> void:
	if _beam_rifle.fire(position):
		#var new_sprite = Sprite2D.new()
		#new_sprite.scale = Vector2(0.4, 0.4)
		#new_sprite.texture = sprite_texture
		#new_sprite.global_position = position
		#add_child(new_sprite)
		for target in hit_targets:
			target.damage(1)

func _on_player_damaged(dmg_val: int):
	_health.damage(dmg_val)

func _on_no_health():
	player_died.emit()

func _on_new_game():
	is_running = true
	_beam_rifle.new_game()
	_health.set_max_health(max_health)
	_health.reset_health()
	_targeting_system.enable()

func _on_game_over():
	is_running = false
	_targeting_system.disable()
