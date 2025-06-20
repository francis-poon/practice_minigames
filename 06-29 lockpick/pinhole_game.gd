extends Node2D

@export var lockpick: Node2D
@export var label: Label
@export var starting_color: Color
@export var good_color: Color
@export var bad_color: Color
@export var lock_pick_indicator: Sprite2D
@export var unlocked_chamber_texture: Texture2D
@export var locked_chamber_texture: Texture2D
@export var chamber_ring: Sprite2D

var rotate_direction = 1
var target_angle: float
var running: bool

func _ready():
	_new()

func _process(delta):
	if running:
		lockpick.rotate(rotate_direction * 1 * delta)
	

func _input(event):
	if event.is_action_pressed("pick") and running:
		rotate_direction *= -1
		label.text = str(snapped(rad_to_deg(angle_difference(target_angle, lockpick.rotation)), 1))
		var pick_accuracy = snapped(1 - absf(angle_difference(target_angle, lockpick.rotation)) / PI, 0.1) + 0.1
		lock_pick_indicator.self_modulate = bad_color.lerp(good_color, pick_accuracy)
		if pick_accuracy >= 0.99:
			_unlock()
		# str(rad_to_deg(angle_difference(target_angle, lockpick.rotation)))

func _new():
	running = true
	target_angle = randf_range(0, 2*PI)
	label.text = ""
	lockpick.rotation = 0
	rotate_direction = 1
	lock_pick_indicator.self_modulate = starting_color
	chamber_ring.texture = locked_chamber_texture
	
	
func _unlock():
	running = false
	print("Chamber unlocked")
	chamber_ring.texture = unlocked_chamber_texture
	pass
