@tool
extends Node2D

@export var name_label: Label

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		name_label.text = name
