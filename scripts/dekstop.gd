extends Control
@onready var musicscreen: Control = $"../musicscreen"
@onready var navigation: Control = $"../navigation"
@onready var guide: Control = $"../guide"
@onready var desktop: Control = $"."
@onready var background_ambience: AudioStreamPlayer = $"../../../BackgroundAmbience"
@onready var clicksfx: AudioStreamPlayer = $"../AudioStreamPlayer"



func _on_nav_pressed() -> void:
	clicksfx.play()
	desktop.visible = false
	musicscreen.visible = false
	guide.visible = false
	navigation.visible = true
	

func _on_specto_pressed() -> void:
	clicksfx.play()
	desktop.visible = false
	guide.visible = false
	navigation.visible = false
	musicscreen.visible = true
	background_ambience.stop()

func _on_guide_pressed() -> void:
	clicksfx.play()
	desktop.visible = false
	navigation.visible = false
	musicscreen.visible = false
	guide.visible = true
	


func _on_exit_pressed() -> void:
	clicksfx.play()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
