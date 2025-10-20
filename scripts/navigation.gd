extends Control
@onready var musicscreen: Control = $"../musicscreen"
@onready var desktop: Control = $"../desktop"
@onready var guide: Control = $"../guide"
@onready var query: Control = $"../query"
@onready var t_1: Button = $t1
@onready var t_2: Button = $t2
@onready var t_3: Button = $t3
@onready var track_2: Control = $"../musicscreen/TrackContainer/track2"
@onready var track_container: Control = $"../musicscreen/TrackContainer"  # Add this line
@onready var navigation: Control = $"."
@onready var background_ambience: AudioStreamPlayer = $"../../../BackgroundAmbience"
@onready var clicksfx: AudioStreamPlayer = $"../AudioStreamPlayer"

func _on_button_pressed() -> void:
	clicksfx.play()
	musicscreen.visible = false
	navigation.visible = false
	guide.visible = false
	query.visible = false
	desktop.visible = true

func _on_t_1_pressed() -> void:
	clicksfx.play()
	musicscreen.visible = false
	navigation.visible = false
	guide.visible = false
	desktop.visible = false
	query.visible = true
	Global.t = 1

func _on_t_2_pressed() -> void:
	clicksfx.play()
	musicscreen.visible = false
	navigation.visible = false
	guide.visible = false
	desktop.visible = false
	query.visible = true
	Global.t = 2

func _on_t_3_pressed() -> void:
	clicksfx.play()
	musicscreen.visible = false
	navigation.visible = false
	guide.visible = false
	desktop.visible = false
	query.visible = true
	Global.t = 3
