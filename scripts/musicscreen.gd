extends Control
@onready var desktop: Control = $"../desktop"
@onready var navigation: Control = $"../navigation"
@onready var guide: Control = $"../guide"
@onready var query: Control = $"../query"
@onready var musicscreen: Control = $"."

func _on_button_pressed() -> void:
	musicscreen.visible = false
	navigation.visible = false
	guide.visible = false
	query.visible = false
	desktop.visible = true
