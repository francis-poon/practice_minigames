class_name SliceableFruit
extends RigidBody2D

enum SliceDirection {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

signal fruit_expired

@export var fruit_sprite: Sprite2D
@export var fruit_textures: Array
@export var arrow_textures: AtlasTexture
@export var slice_direction_sprite: Sprite2D
@export var target_sprite: Sprite2D
@export var animation_player: AnimationPlayer
@export var slice_sprite: Sprite2D
@export var expire_time: float = 2.5
@export var expire_timer: Timer

var sliced_state: bool
var slice_direction: SliceDirection
var default_gravity_scale: float = 0.3

func _ready() -> void:
	sliced_state = false
	fruit_sprite.texture = fruit_textures.pick_random()
	slice_direction = SliceDirection.values().pick_random()
	arrow_textures.region.position.x = slice_direction * arrow_textures.region.size.x
	slice_direction_sprite.texture = arrow_textures.duplicate()
	target_sprite.hide()
	expire_timer.wait_time = expire_time
	expire_timer.timeout.connect(_on_expire_timeout)
	gravity_scale = 0

func slice(direction: SliceDirection) -> bool:
	var tween = get_tree().create_tween()
	sliced_state = direction == slice_direction
	if sliced_state:
		expire_timer.stop()
		target_sprite.hide()
		slice_direction_sprite.hide()
		fruit_sprite.modulate
		tween.parallel().tween_property(fruit_sprite, "modulate", Color.TRANSPARENT, 0.3)
		match direction:
			SliceDirection.UP:
				slice_sprite.flip_h = false
				slice_sprite.rotation_degrees = 90
			SliceDirection.DOWN:
				slice_sprite.flip_h = false
				slice_sprite.rotation_degrees = -90
			SliceDirection.LEFT:
				slice_sprite.flip_h = false
				slice_sprite.rotation_degrees = 0
			SliceDirection.RIGHT:
				slice_sprite.flip_h = true
				slice_sprite.rotation_degrees = 0
		animation_player.play("slice")
	return sliced_state

func target():
	target_sprite.show()

func launch(angle: float, impulse: float):
	expire_timer.start()
	gravity_scale = default_gravity_scale
	var impulse_vector = Vector2(0, impulse).rotated(angle)
	apply_central_impulse(impulse_vector)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slice":
		queue_free()

func _on_expire_timeout():
	fruit_expired.emit()
	queue_free()
