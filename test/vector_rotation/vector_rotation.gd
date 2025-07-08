extends Node2D

@export var label: Label

func _ready():
	var vector = Vector2(1,0)
	label.text = "{0} {1}".format([vector, vector.rotated(PI/2)])
