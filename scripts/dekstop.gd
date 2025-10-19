extends Control
@onready var musicscreen: Control = $"../musicscreen"
@onready var navigation: Control = $"../navigation"
@onready var guide: Control = $"../guide"
@onready var desktop: Control = $"."



func _on_nav_pressed() -> void:
	desktop.visible = false
	musicscreen.visible = false
	guide.visible = false
	navigation.visible = true


func _on_specto_pressed() -> void:
	desktop.visible = false
	guide.visible = false
	navigation.visible = false
	musicscreen.visible = true


func _on_guide_pressed() -> void:
	desktop.visible = false
	navigation.visible = false
	musicscreen.visible = false
	guide.visible = true
	


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
