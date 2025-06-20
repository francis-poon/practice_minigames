extends Node2D

@export var line_1: ColorRect
@export var line_2: ColorRect
@export var label: Label

func _ready():
	for i in range(3):
		print(i)

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		line_2.rotation += 1 * delta
	if Input.is_action_pressed("ui_right"):
		line_2.rotation += -1 * delta
	if Input.is_action_pressed("ui_up"):
		line_1.rotation += 1 * delta
	if Input.is_action_pressed("ui_down"):
		line_1.rotation += -1 * delta
	label.text = "line 1 angle: {0}\nline 2 angle: {1}\ndifference: {2}".format([
		str(rad_to_deg(line_1.rotation)),
		str(rad_to_deg(line_2.rotation)),
		str(rad_to_deg(angle_difference(line_1.rotation, line_2.rotation)))])
