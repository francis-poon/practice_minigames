extends RigidBody2D

@export var label: Label
@export var start_force: float = 20

var force_multiplier: float:
	set(value):
		force_multiplier = value
		label.text = str(value)

func _ready():
	force_multiplier = start_force
	gravity_scale = 0

func _input(event: InputEvent):
	if event.is_action_pressed("apply_force"):
		apply_impulse(Vector2(0, -force_multiplier))
	if event.is_action_pressed("increase_force", true):
		force_multiplier *= 1.1
	if event.is_action_pressed("decrease_force", true):
		force_multiplier /= 1.1

func launch(impulse: Vector2):
	gravity_scale = 1
	apply_impulse(impulse)
