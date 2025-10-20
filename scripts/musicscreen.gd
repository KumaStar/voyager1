extends Control
@onready var desktop: Control = $"../desktop"
@onready var navigation: Control = $"../navigation"
@onready var guide: Control = $"../guide"
@onready var query: Control = $"../query"
@onready var background_ambience: AudioStreamPlayer = $"../../../BackgroundAmbience"
@onready var musicscreen: Control = $"."
@onready var clicksfx: AudioStreamPlayer = $"../AudioStreamPlayer"


func _on_backtodesktop_pressed() -> void:
	clicksfx.play()
	musicscreen.visible = false
	navigation.visible = false
	guide.visible = false
	query.visible = false
	desktop.visible = true
	background_ambience.play()
