extends Node2D

@export var line_2d: Line2D
@export var grid_cont: GridContainer
@export var debug_label: Label

var current_point_index: int = 0
var current_val_a: String = "":
	set(value):
		current_val_a = value
		_update_label()
var current_val_b: String = "":
	set(value):
		current_val_b = value
		_update_label()

var new_val_a: String = "":
	set(value):
		new_val_a = value
		_update_label()
var new_val_b: String = "":
	set(value):
		new_val_b = value
		_update_label()

func _ready():
	for child in grid_cont.get_children():
		child = child as Button
		child.mouse_entered_pos.connect(_on_mouse_entered_pos)
		child.mouse_pressed.connect(_on_mouse_pressed)

func _on_mouse_entered_pos(pos: Vector2, val_a: String, val_b: String):
	if current_point_index <= line_2d.get_point_count() - 1:
		line_2d.remove_point(line_2d.get_point_count() - 1)
	line_2d.add_point(pos)
	new_val_a = val_a
	new_val_b = val_b

func _on_mouse_pressed(button: Button):
	if (current_val_a == "" and current_val_b == "") or \
	current_val_a == new_val_a or current_val_b == new_val_b:
		button.disabled = true
		current_point_index += 1
		current_val_a = new_val_a
		current_val_b = new_val_b

func _update_label():
	debug_label.text = "Current Val: {0}{1}\nNew Val: {2}{3}".format([current_val_a, current_val_b, new_val_a, new_val_b])
