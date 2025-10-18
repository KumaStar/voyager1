extends AnimatedSprite2D

# Big rectangle (outer bounds) 
var big_rect = Rect2(Vector2(645, 104), Vector2(1620 - 645, 1020 - 104)) 
# Small rectangle (inner bounds) 
var small_rect = Rect2(Vector2(790, 221), Vector2(1466 - 790, 737 - 221))

var move_speed: float = 16.5  # Cursor lerp speed

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	modulate.a = 1.0  # Always visible

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	
	# Smoothly move the cursor toward the mouse
	global_position = lerp(global_position, mouse_pos, move_speed * delta)
	
	# Switch frames based on rectangle positions
	if small_rect.has_point(mouse_pos):
		frame = 1  # Inside small rectangle
	elif big_rect.has_point(mouse_pos):
		frame = 0  # Outside small rectangle but inside big rectangle
	else:
		frame = 2  # Outside big rectangle, show dot
