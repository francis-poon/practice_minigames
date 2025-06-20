class_name ShapeMatchTile
extends Control

signal mouse_pressed

@export var color_rect: ColorRect
@export var label: Label
@export var button: Button

var val_a: String
var val_b: String

var val_a_list = ["a", "b", "c"]
var val_b_list = ["1", "2", "3"]

func _ready():
	val_a = val_a_list.pick_random()
	val_b = val_b_list.pick_random()
	label.text = val_a + val_b
	button.pressed.connect(_on_button_pressed)

func _on_button_mouse_entered() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mouse_pressed.emit()

func _on_button_pressed():
	mouse_pressed.emit()
