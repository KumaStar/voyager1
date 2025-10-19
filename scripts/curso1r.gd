#extends Control  # Script on your "cursor" Control node
#
#@onready var t_1: TextureRect = $"../../t1"
#@onready var musicscreen: Control = $"../../../musicscreen"
#@onready var guide: Control = $"../../../guide"
#@onready var query: Control = $"../../../query"
#@onready var desktop: Control = $"../../../desktop"
#@onready var navigation: Control = $"../.."
#@onready var cursor: ColorRect = $"."
#@onready var t_2: TextureRect = $"../../t2"
#
#func _ready() -> void:
	#mouse_filter = Control.MOUSE_FILTER_IGNORE  # Let clicks go through
#
#func _process(_delta: float) -> void:
	#var cursor_rect = Rect2(global_position, size)
	#var texture_rect = Rect2(t_1.global_position, t_1.size)
#
	## Check if cursor overlaps the texture
	#if cursor_rect.intersects(texture_rect):
		#musicscreen.visible = false
		#navigation.visible = false
		#guide.visible = false
		#desktop.visible = false
		#query.visible = true
		#cursor.position = Vector2(0, 0)
		#t_1.visible = false
		#t_2.visible = true
		#
	
