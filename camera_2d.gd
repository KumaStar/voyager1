
#under canvas layer the things wont move with the mouse thing script below



extends Camera2D

# maximum camera sway in pixels (X = left/right, Y = up/down)
@export var max_offset := Vector2(50, 25)
# how quickly the camera follows the target offset
@export var follow_speed := 6.0
# computer screen area in viewport coordinates
@export var computer_rect := Rect2(Vector2(640, 105), Vector2(979, 915))

var target_position := Vector2.ZERO
func _ready():
	position = Vector2.ZERO

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()

	if computer_rect.has_point(mouse_pos):
		# cursor inside computer area — keep camera centered
		target_position = Vector2.ZERO
	else:
		# convert mouse position to a normalized range [-1, 1]
		var offset = Vector2(
			(mouse_pos.x / 1920.0 - 0.5) * 2.0,
			(mouse_pos.y / 1080.0 - 0.5) * 2.0
		)

		# calculate the limited offset
		target_position = Vector2(offset.x * max_offset.x, offset.y * max_offset.y)

	# smooth movement toward target
	position = lerp(position, target_position, delta * follow_speed)
