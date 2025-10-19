extends Control

# Buttons
@onready var btn_play_pause: Button = $"../BtnPLayPause"
@onready var btn_next: Button = $"../BtnNext"
@onready var btn_prev: Button = $"../BtnPrev"

# Music screen node
@onready var musicscreen: Control = $".."

# Container of track nodes
@onready var track_container: Control = $"."

# Optional label to show messages
@onready var label: Label = $"../Label"

# Scroll speed (pixels per second)
@export var scroll_speed: float = 40.0  # default fallback

# Current track index in track_container
var current_track_index: int = 0

# Whether music is playing
var is_playing: bool = false

# List of enabled track indices
var enabled_tracks: Array = []

func _ready() -> void:
	# Initialize enabled tracks (start with first track)
	enabled_tracks = [0]
	current_track_index = enabled_tracks[0]
	update_active_track()

	# Show message if only 1 track is enabled
	if enabled_tracks.size() == 1 and label:
		label.text = "Only 1 track is available currently"
	elif label:
		label.text = ""

	# Connect buttons$=
	btn_play_pause.pressed.connect(_on_play_pause_pressed)
	btn_next.pressed.connect(_on_next_pressed)
	btn_prev.pressed.connect(_on_prev_pressed)


func _process(delta: float) -> void:
	if not is_playing:
		return

	var player: AudioStreamPlayer = get_current_player()
	if not player:
		return

	# Pause if music screen is hidden
	if not musicscreen.visible:
		if player.playing:
			player.stream_paused = true
		is_playing = false
		return

	var current_track: Control = track_container.get_child(current_track_index)
	var spectrogram: TextureRect = current_track.get_node_or_null("Spectrogram") as TextureRect

	# Scroll spectrogram
	if spectrogram:
		spectrogram.position.x -= scroll_speed * delta

	# Track ended: stop playing and reset spectrogram
	if not player.playing:
		is_playing = false
		if spectrogram:
			spectrogram.position.x = 0


func _on_play_pause_pressed() -> void:
	var player: AudioStreamPlayer = get_current_player()
	if not player:
		return

	if player.playing:
		player.stream_paused = true
	else:
		if player.stream_paused:
			player.stream_paused = false
		else:
			player.play()

	is_playing = player.playing


func _on_next_pressed() -> void:
	if enabled_tracks.size() <= 1:
		return

	var player: AudioStreamPlayer = get_current_player()
	if player:
		player.stop()

	var idx = enabled_tracks.find(current_track_index)
	idx = (idx + 1) % enabled_tracks.size()
	current_track_index = enabled_tracks[idx]

	update_active_track()
	get_current_player().play()
	is_playing = true


func _on_prev_pressed() -> void:
	if enabled_tracks.size() <= 1:
		return

	var player: AudioStreamPlayer = get_current_player()
	if player:
		player.stop()

	var idx = enabled_tracks.find(current_track_index)
	idx = (idx - 1 + enabled_tracks.size()) % enabled_tracks.size()
	current_track_index = enabled_tracks[idx]

	update_active_track()
	get_current_player().play()
	is_playing = true


func get_current_player() -> AudioStreamPlayer:
	var track: Control = track_container.get_child(current_track_index)
	if not track:
		return null
	return track.get_node_or_null("AudioPlayer") as AudioStreamPlayer


func update_active_track() -> void:
	for i in range(track_container.get_child_count()):
		var track: Control = track_container.get_child(i)

		var spectrogram: TextureRect = track.get_node_or_null("Spectrogram") as TextureRect
		var player: AudioStreamPlayer = track.get_node_or_null("AudioPlayer") as AudioStreamPlayer

		if spectrogram:
			spectrogram.visible = (i == current_track_index)
			spectrogram.position.x = 0

		if player and i != current_track_index:
			player.stop()
			player.stream_paused = false

	# Configure scroll speed based on track duration
	var active_track: Control = track_container.get_child(current_track_index)
	var active_spectrogram: TextureRect = active_track.get_node_or_null("Spectrogram") as TextureRect
	var active_player: AudioStreamPlayer = active_track.get_node_or_null("AudioPlayer") as AudioStreamPlayer

	if active_player and active_player.stream and active_spectrogram:
		var duration: float = active_player.stream.get_length()
		if duration > 0:
			scroll_speed = active_spectrogram.size.x / duration
			print("🎵 Calculated scroll speed for track ", current_track_index, ": ", scroll_speed)
		else:
			scroll_speed = 40.0  # fallback

# Add this function to your TrackContainer script
func add_track_to_enabled(track_index: int) -> void:
	if track_index not in enabled_tracks:
		enabled_tracks.append(track_index)
		
		# Update label if needed
		if enabled_tracks.size() == 1 and label:
			label.text = "Only 1 track is available currently"
		elif label:
			label.text = ""
		
		print("Track ", track_index, " added. Enabled tracks: ", enabled_tracks)
