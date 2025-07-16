extends Timer

func _on_timeout() -> void:
	GundamGameEvents.emit_game_tick()
