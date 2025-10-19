extends Control

@onready var knob_x: TextureRect = $KnobX
@onready var knob_y: TextureRect = $KnobY
@onready var cursor: TextureRect = $Cursor

var selected_knob: TextureRect = null
var knob_x_value: float = 0
var knob_y_value: float = 0

func _ready():
	# Debug: Print all child nodes
	print("Children of ", name, ":")
	for child in get_children():
		print("  - ", child.name, " (", child.get_class(), ")")
	
	# Check which nodes are null
	if knob_x == null:
		print("knob_x is NULL - check node name")
	if knob_y == null:
		print("knob_y is NULL - check node name")
	if cursor == null:
		print("cursor is NULL - check node name")

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if knob_x != null and knob_x.get_global_rect().has_point(event.position):
				selected_knob = knob_x
			elif knob_y != null and knob_y.get_global_rect().has_point(event.position):
				selected_knob = knob_y
		else:
			selected_knob = null

func _process(delta):
	if selected_knob != null and cursor != null:
		var value_ptr = knob_x_value if selected_knob == knob_x else knob_y_value
		
		if Input.is_key_pressed(KEY_A):
			value_ptr += delta * 0.5
		if Input.is_key_pressed(KEY_D):
			value_ptr -= delta * 0.5
		
		value_ptr = clamp(value_ptr, 0, 1)
		
		if selected_knob == knob_x:
			knob_x_value = value_ptr
		else:
			knob_y_value = value_ptr
		
		var max_x = size.x - cursor.size.x
		var max_y = size.y - cursor.size.y
		cursor.position = Vector2(knob_x_value * max_x, knob_y_value * max_y)
