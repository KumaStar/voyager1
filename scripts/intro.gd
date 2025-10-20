extends Node2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	animation_player.play("sattelite")  # Replace "intro" with your animation name
	var anim_length = animation_player.current_animation_length
	await get_tree().create_timer(anim_length).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _process(delta: float) -> void:
	if Input.is_action_pressed("skip"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
