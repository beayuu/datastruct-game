extends StaticBody2D

@export var move_distance := 32
var is_moving := false

func push(dir: Vector2) -> void:
	if is_moving:
		return

	var target_pos = global_position + dir.normalized() * move_distance

	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray_2d({
		"from": global_position,
		"to": target_pos,
		"collision_mask": 1 << 1  # optional: your block layer
	})

	if result == null:
		slide_to(target_pos)


func slide_to(target_pos: Vector2):
	is_moving = true

	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_pos, 0.15)

	tween.finished.connect(func():
		is_moving = false)
