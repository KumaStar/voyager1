extends Control

@onready var musicscreen: Control = $"../musicscreen"
@onready var navigation: Control = $"../navigation"
@onready var desktop: Control = $"../desktop"
@onready var guide: Control = $"."


func _on_button_pressed() -> void:
	musicscreen.visible = false
	navigation.visible = false
	guide.visible = false
	desktop.visible = true
