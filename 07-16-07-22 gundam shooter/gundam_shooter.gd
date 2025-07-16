extends Node2D

@export var player: GundamPlayer
@export var _start_screen_label: RichTextLabel
@export var _start_button: Button
@export var _score: GundamScore

var is_running: bool

func _ready():
	is_running = false
	_start_screen_label.text = "START\n[font_size={18}]< PRESS ANY KEY TO START >[/font_size]"
	_start_screen_label.show()
	_start_button.disabled = false
	_start_button.show()
	player.player_died.connect(_on_player_died)
	GundamGameEvents.add_points.connect(_on_add_points)

func _input(event: InputEvent) -> void:
	if not is_running:
		if event.is_pressed():
			new_game()

func new_game():
	is_running = true
	_start_screen_label.hide()
	_start_button.disabled = true
	_start_button.hide()
	GundamGameEvents.emit_new_game()

func game_over():
	_start_screen_label.show()
	_start_screen_label.text = "GAME OVER"
	await get_tree().create_timer(2.0).timeout
	_start_screen_label.text = "PLAY AGAIN?\n[font_size={18}]< PRESS ANY KEY TO START >[/font_size]"
	_start_button.disabled = false
	_start_button.show()
	is_running = false
	GundamGameEvents.emit_game_over()

func _on_player_died():
	game_over()

func _on_add_points(points: int):
	_score.add_points(points)
