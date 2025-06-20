extends Node2D

@export var label: Label
@export var line: Line2D
@export var camera: Camera2D
@export var projectile: RigidBody2D

var point_a: Vector2:
	set(value):
		point_a = value
		_update_mouse_tracker()
var point_b: Vector2:
	set(value):
		point_b = value
		_update_mouse_tracker()
var tracking: bool = false

var label_template ="Point A: {0}\nPoint B: {1}\nAngle: {2}"

func _ready():
	line.clear_points()
	label.text = label_template.format(["","",""])

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if (event as InputEventMouseButton).pressed:
			#point_a = projectile.to_local((event as InputEventMouseButton).global_position)
			point_a = event.global_position
			tracking = true
			line.add_point(point_a)
			line.add_point(point_a)
		else:
			line.clear_points()
			tracking = false
			projectile.launch((point_a-point_b) * projectile.force_multiplier)
			point_a = Vector2.ZERO
	if event is InputEventMouseMotion and tracking:
		#point_b = projectile.to_local((event as InputEventMouseMotion).global_position)
		projectile.global_position += event.global_position - point_b
		point_b = event.global_position
		line.set_point_position(1, point_b)
		

func _update_mouse_tracker():
	if tracking:
		var angle = rad_to_deg(-point_b.angle_to_point(point_a))
		
		label.text= label_template.format([point_a, point_b, angle])
	else:
		label.text = label_template.format(["","",""])
