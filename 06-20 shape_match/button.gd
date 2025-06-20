class_name TestMatchButton_0
extends Button

signal mouse_entered_pos(pos: Vector2, val_a: String, val_b: String)
signal mouse_pressed(button: Button)

var val_a: String
var val_b: String

var val_a_list = ["a", "b", "c"]
var val_b_list = ["1", "2", "3"]

func _ready():
	val_a = val_a_list.pick_random()
	val_b = val_b_list.pick_random()
	text = val_a + val_b
	pressed.connect(_on_pressed)

func _on_mouse_entered():
	mouse_entered_pos.emit(global_position + size / 2, val_a, val_b)


func _on_pressed():
	mouse_pressed.emit(self)
