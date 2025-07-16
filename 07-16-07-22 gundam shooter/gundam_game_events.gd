extends Node

signal new_game
signal game_over
signal game_tick

signal player_damaged(dmg_val: int)
signal add_points(points: int)

func emit_player_damaged(dmg_val: int):
	player_damaged.emit(dmg_val)

func emit_new_game():
	new_game.emit()

func emit_game_over():
	game_over.emit()

func emit_add_points(points: int):
	add_points.emit(points)

func emit_game_tick():
	game_tick.emit()
