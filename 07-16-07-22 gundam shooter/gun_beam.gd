class_name GundamBeam
extends Node

@export var line_a: Line2D
@export var line_b: Line2D

func _ready() -> void:
	line_a.modulate = Color.TRANSPARENT
	line_b.modulate = Color.TRANSPARENT

func fire(origin: Vector2, destination: Vector2):
	line_a.set_point_position(0, origin)
	line_a.set_point_position(1, destination)
	line_a.modulate = Color.WHITE
	line_b.set_point_position(0, origin)
	line_b.set_point_position(1, destination)
	line_b.modulate = Color.WHITE
	
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(line_a, "modulate", Color.TRANSPARENT, 1)
	tween.parallel().tween_property(line_b, "modulate", Color.TRANSPARENT, 1)
	tween.tween_callback(queue_free)
