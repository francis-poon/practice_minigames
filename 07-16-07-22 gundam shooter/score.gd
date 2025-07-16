class_name GundamScore
extends Label

var score:
	set(value):
		score = value
		text = "Score: " + str(value)

func _ready():
	score = 0

func new_game():
	score = 0

func add_points(points: int):
	score += points
