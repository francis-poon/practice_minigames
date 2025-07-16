extends Camera2D

@export var move_speed: float = 50

var _input_vector: Vector2


func _physics_process(delta: float) -> void:
	position = get_screen_center_position()
	position += _input_vector * move_speed * delta

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_right"):
		_input_vector.x += 1
	if event.is_action_pressed("move_left"):
		_input_vector.x += -1
	
	if event.is_action_pressed("move_up"):
		_input_vector.y += -1
	if event.is_action_pressed("move_down"):
		_input_vector.y += 1
		
	if event.is_action_released("move_right"):
		_input_vector.x = 0
	if event.is_action_released("move_left"):
		_input_vector.x = 0
	
	if event.is_action_released("move_up"):
		_input_vector.y = 0
	if event.is_action_released("move_down"):
		_input_vector.y = 0
