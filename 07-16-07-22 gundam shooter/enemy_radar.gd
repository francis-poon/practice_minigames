extends Node

@export var radar_scan_time: float

@export var detection_rect: ColorRect
@export var screen_center: Control
@export var _radar_scan_timer: Timer

@export var up_indicator: TextureRect
@export var down_indicator: TextureRect
@export var left_indicator: TextureRect
@export var right_indicator: TextureRect

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

func _ready() -> void:
	hide_indicators()
	_radar_scan_timer.start(radar_scan_time)
	

func _scan() -> void:
	var indicator_directions: Dictionary = {}
	for enemy in get_tree().get_nodes_in_group("gundam enemy"):
		if not enemy is GundamEnemy:
			continue
		var target_rect = enemy.get_rect()
		var enemy_dir: Vector2 = target_rect.get_center() - screen_center.position
		var enemy_dir_angle = enemy_dir.angle_to(Vector2(1,-1))
	
		if not detection_rect.get_rect().intersects(target_rect):
			if enemy_dir_angle < -PI/2:
				indicator_directions[Direction.DOWN] = true
			elif enemy_dir_angle < 0:
				indicator_directions[Direction.RIGHT] = true
			elif enemy_dir_angle < PI/2:
				indicator_directions[Direction.UP] = true
			else:
				indicator_directions[Direction.LEFT] = true
		
		if indicator_directions.size() <= 0:
			hide_indicators()
			return
		
		play_indicators(indicator_directions)

func hide_indicators():
	up_indicator.hide()
	down_indicator.hide()
	left_indicator.hide()
	right_indicator.hide()

func play_indicators(directions: Dictionary):
	hide_indicators()
	
	for direction in directions.keys():
		match direction:
			Direction.UP:
				up_indicator.show()
			Direction.DOWN:
				down_indicator.show()
			Direction.LEFT:
				left_indicator.show()
			Direction.RIGHT:
				right_indicator.show()
