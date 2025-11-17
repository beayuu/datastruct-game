extends StaticBody2D

var dragging := false
var drag_offset := Vector2.ZERO

func _ready():
	input_pickable = true  # Required for _input_event to fire
	set_process(true)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Start drag if the click hit this body's collision
			dragging = true
			drag_offset = global_position - get_global_mouse_position()
			z_index = 100
		else:
			dragging = false
			z_index = 0
			# Optional snap:
			# global_position = global_position.snapped(Vector2(64, 64))

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() + drag_offset
