extends Control

@export var target_positions: Control
@export var items: Control

var current_index = 0


func _ready():
	#for i in target_positions.get_children():
		#i.hide()
	
	await get_tree().process_frame
	for i in range(items.get_children().size()):
		var target_position = target_positions.get_child(i).global_position + (target_positions.get_child(i).size - items.get_child(i).size) / 2
		items.get_child(i).global_position = target_position
		print(i)
		print(target_positions.get_child(i))


func _input(event):
	if event.is_action_pressed("ui_left"):
		_go_left()
	if event.is_action_pressed("ui_right"):
		_go_right()

func _go_left():
	if current_index <= 0:
		pass
	
	current_index -= 1
	_tween_to_index()


func _go_right():
	if current_index >= target_positions.get_children().size():
		pass
	
	current_index += 1
	_tween_to_index()

func _tween_to_index():
	var tween = get_tree().create_tween()
	
	var target = target_positions.get_child(current_index)
	var p_animation_duration = 0.5
	
	for i in range(items.get_children().size()):
		var item = items.get_child(i)
		target = target_positions.get_child(current_index + i)
		var target_position = target.global_position + (target.size - item.size) / 2
		tween.parallel().tween_property(item, "global_position", target_position, p_animation_duration)
	#tween.parallel().tween_property(item, "anchor_left", target.anchor_left, p_animation_duration)
	#tween.parallel().tween_property(item, "anchor_right", target.anchor_right, p_animation_duration)
	#tween.parallel().tween_property(item, "anchor_top", target.anchor_top, p_animation_duration)
	#tween.parallel().tween_property(item, "anchor_bottom", target.anchor_bottom, p_animation_duration)
	#tween.parallel().tween_property(item, "offset_left", target.offset_left, p_animation_duration)
	#tween.parallel().tween_property(item, "offset_right", target.offset_right, p_animation_duration)
	#tween.parallel().tween_property(item, "offset_top", target.offset_top, p_animation_duration)
	#tween.parallel().tween_property(item, "offset_bottom", target.offset_bottom, p_animation_duration)
	#tween.parallel().tween_property(item, "z_index", target.z_index, p_animation_duration)
