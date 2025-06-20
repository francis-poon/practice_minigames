extends Node2D

@export var pinhole_holder: Node
@export var pinhole_index_label: Label

var pinhole_index

func _ready() -> void:
	pinhole_index = 0
	for i in pinhole_holder.get_children():
		i.hide()
	pinhole_holder.get_child(pinhole_index).show()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		pass
	if event.is_action_pressed("ui_right"):
		pass
