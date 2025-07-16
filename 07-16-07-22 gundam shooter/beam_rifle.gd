class_name GundamBeamRifle
extends Node

@export var beam_scene: PackedScene

@export var _beam_origin: Control
@export var _ammo: GundamAmmo

func new_game():
	_ammo.new_game()

func fire(target_pos: Vector2) -> bool:
	if _ammo.use_ammo(1):
		var beam: GundamBeam = beam_scene.instantiate()
		add_child(beam)
		beam.fire(_beam_origin.global_position, target_pos)
		return true
	
	return false
