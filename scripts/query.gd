extends Control
@onready var musicscreen: Control = $"../musicscreen"
@onready var desktop: Control = $"../desktop"
@onready var guide: Control = $"../guide"
@onready var navigation: Control = $"../navigation"
@onready var query: Control = $"."
@onready var track_container: Control = $"../musicscreen/TrackContainer"
@onready var t_1: Button = $"../navigation/t1"
@onready var t_2: Button = $"../navigation/t2"
@onready var t_3: Button = $"../navigation/t3"
@onready var popup: ColorRect = $"../desktop/popup"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var clicksfx: AudioStreamPlayer = $"../AudioStreamPlayer"
@onready var btnsfx: AudioStreamPlayer = $"../AudioStreamPlayer2"


func _on_button_pressed() -> void:
	clicksfx.play()
	musicscreen.visible = false
	navigation.visible = false
	guide.visible = false
	query.visible = false
	desktop.visible = true
	

func _on_yes_pressed() -> void:
	btnsfx.play()
	if Global.t==1:
		query.visible = false
		desktop.visible = true
		track_container.add_track_to_enabled(1)
		animation_player.play("unlock")
		t_1.visible = false
		t_2.visible = true
		
	elif Global.t==2:
		query.visible = false
		desktop.visible = true
		track_container.add_track_to_enabled(2)
		animation_player.play("unlock")
		t_2.visible = false
		t_3.visible = true

	else:
		get_tree().change_scene_to_file("res://scenes/gameover.tscn")

func _on_no_pressed() -> void:
	btnsfx.play()
	if Global.t==3:
		track_container.add_add_track_to_enabled(3)
		animation_player.play("unlock")
		query.visible = false
		desktop.visible = true
		t_3.visible = false
		#t4.visible.......
	else:
		get_tree().change_scene_to_file("res://scenes/gameover.tscn")
