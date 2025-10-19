extends ColorRect

@export var min_value: float = 0.0
@export var max_value: float = 1.0
@export var sensitivity: float = 0.005

var value: float = 0.5
var dragging: bool = false
var last_mouse_pos: Vector2

signal value_changed(new_value)

func _ready():
	update_rotation()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and get_global_rect().has_point(event.position):
				dragging = true
				last_mouse_pos = event.position
			else:
				dragging = false

	elif event is InputEventMouseMotion and dragging:
		var delta = event.position - last_mouse_pos
		value += delta.x * sensitivity
		value = clamp(value, min_value, max_value)
		emit_signal("value_changed", value)
		update_rotation()
		last_mouse_pos = event.position

func update_rotation() -> void:
	rotation = lerp_angle(0.0, TAU, float((value - min_value) / (max_value - min_value)))
