extends Node2D

@export var start_button: Button
@export var spawn_delay: float = 0.6
@export var start_screen_label: RichTextLabel
@export var round_label: Label
@export var level_manager: FruitNinjaLevelManager

var is_game_running: bool
var is_ready_to_start: bool

func _ready():
	start_screen_label.text = "START\n[font_size={18}]< PRESS ANY KEY TO START >[/font_size]"
	is_game_running = false
	is_ready_to_start = true
	level_manager.level_failed.connect(_on_level_failed)
	level_manager.level_complete.connect(_on_level_complete)
	level_manager.all_levels_complete.connect(_on_all_levels_complete)
 
func _input(event: InputEvent) -> void:
	if not is_game_running:
		if event.is_pressed() and is_ready_to_start:
			new_game()
		return
	
	var slice_direction: SliceableFruit.SliceDirection
	var is_slicing: bool = false
	if event.is_action_pressed("ui_up"):
		slice_direction = SliceableFruit.SliceDirection.UP
		is_slicing = true
	if event.is_action_pressed("ui_down"):
		slice_direction = SliceableFruit.SliceDirection.DOWN
		is_slicing = true
	if event.is_action_pressed("ui_left"):
		slice_direction = SliceableFruit.SliceDirection.LEFT
		is_slicing = true
	if event.is_action_pressed("ui_right"):
		slice_direction = SliceableFruit.SliceDirection.RIGHT
		is_slicing = true
	if is_slicing:
		level_manager.slice(slice_direction)
	
func new_game():
	round_label.hide()
	is_ready_to_start = false
	start_button.disabled = true
	for i in range(3):
		start_screen_label.text = str(3 - i)
		await get_tree().create_timer(1.0).timeout
	start_screen_label.text = "GO!"
	await get_tree().create_timer(1.0).timeout
	start_button.hide()
	start_screen_label.hide()
	round_label.text = "ROUND {0}".format([level_manager.current_level_index + 1])
	round_label.show()
	is_game_running = true
	level_manager.new_game()


func game_over():
	is_game_running = false
	start_button.show()
	start_screen_label.show()
	start_button.disabled = false
	start_screen_label.text = "GAME OVER"
	await get_tree().create_timer(1.0).timeout
	is_ready_to_start = true
	start_screen_label.text = "TRY AGAIN?\n[font_size={18}]< PRESS ANY KEY TO START >[/font_size]"

func game_complete():
	is_game_running = false
	start_button.show()
	start_screen_label.show()
	start_button.disabled = false
	start_screen_label.text = "YOU WIN!"
	await get_tree().create_timer(1.0).timeout
	is_ready_to_start = true
	start_screen_label.text = "PLAY AGAIN?\n[font_size={18}]< PRESS ANY KEY TO START >[/font_size]"

#func _spawn_new_fruit():
	#await get_tree().create_timer(spawn_delay).timeout
	##for fruit: Node in fruit_bar:
		##remove_child(fruit)
	#
	#current_fruit_index = 0
	#fruit_bar_size += 1
	#fruit_bar.resize(fruit_bar_size)
	#
	#round_label.text = "ROUND {0}".format([fruit_bar_size])
	#round_timer.start()
	#for i in range(fruit_bar_size):
		#fruit_bar[i] = fruit_scene.instantiate()
		#fruit_bar[i].position = Vector2(48 * i - 24 * (fruit_bar_size - 1), spawn_point.position.y)
		#add_child(fruit_bar[i])
		#fruit_bar[i].apply_central_impulse(Vector2(0, launch_impulse))
	#fruit_bar[0].target()


func _on_level_failed():
	if is_game_running:
		game_over()

func _on_level_complete():
	await get_tree().create_timer(spawn_delay).timeout
	round_label.text = "ROUND {0}".format([level_manager.current_level_index + 1])
	level_manager.start_level()

func _on_all_levels_complete():
	game_complete()
