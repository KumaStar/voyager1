extends Control

# Buttons
@onready var btn_play_pause: Button = $"../BtnPLayPause"
@onready var btn_next: Button = $"../BtnNext"
@onready var btn_prev: Button = $"../BtnPrev"

# Music screen node
@onready var playsfx: AudioStreamPlayer = $"../playsfx"
@onready var pausesfx: AudioStreamPlayer = $"../pausesfx"
@onready var next: AudioStreamPlayer = $"../next"
@onready var musicscreen: Control = $".."

# Container of track nodes
@onready var track_container: Control = $"."
@onready var trackname: Label = $"../trackname"

# Optional label to show messages
@onready var label: Label = $"../Label"

# Scroll speed (pixels per second)
@export var scroll_speed: float = 40.0  # default fallback

# Current track index in track_container
var current_track_index: int = 0

# Whether music is playing
var is_playing: bool = false

# List of enabled track indices
var names = ["SE@)22124", "2{]g214v2", "Cha4r2lfa3ie", "Di21an24a"]
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

	# Connect buttons
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
	
	trackname.text = names[current_track_index]
	
	# Scroll spectrogram
	if spectrogram:
		spectrogram.position.x -= scroll_speed * delta

	# Track ended: reset and replay automatically
	if not player.playing and not player.stream_paused:
		# Reset spectrogram position
		if spectrogram:
			spectrogram.position.x = 0
		
		# Restart the track
		player.play()
		is_playing = true
		print("🔄 Track ended, restarting automatically")


func _on_play_pause_pressed() -> void:
	var player: AudioStreamPlayer = get_current_player()
	if not player:
		return

	if player.playing:
		pausesfx.play()
		player.stream_paused = true
		is_playing = false
	else:
		if player.stream_paused:
			playsfx.play()
			player.stream_paused = false
			is_playing = true
		else:
			playsfx.play()
			player.play()
			is_playing = true


func _on_next_pressed() -> void:
	next.play()
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

	# Configure scroll speed based on track duration and texture width
	var active_track: Control = track_container.get_child(current_track_index)
	var active_spectrogram: TextureRect = active_track.get_node_or_null("Spectrogram") as TextureRect
	var active_player: AudioStreamPlayer = active_track.get_node_or_null("AudioPlayer") as AudioStreamPlayer

	if active_player and active_player.stream and active_spectrogram:
		var duration: float = active_player.stream.get_length()
		if duration > 0:
			# Get the actual texture width (not the TextureRect size)
			var texture_width: float = 0.0
			if active_spectrogram.texture:
				texture_width = active_spectrogram.texture.get_width()
			else:
				# Fallback to size if no texture
				texture_width = active_spectrogram.size.x
			
			# Account for the texture scale (0.57 in your case)
			var scale_x: float = active_spectrogram.scale.x
			var actual_width: float = texture_width * scale_x
			
			# Calculate scroll speed: texture needs to scroll its scaled width in duration time
			scroll_speed = actual_width / duration
			print("🎵 Track ", current_track_index, " - Duration: ", duration, "s, Texture: ", texture_width, "px, Scale: ", scale_x, ", Actual width: ", actual_width, "px, Scroll speed: ", scroll_speed, " px/s")
		else:
			scroll_speed = 40.0  # fallback
			print("⚠️ Track ", current_track_index, " has no duration, using fallback speed")


func add_track_to_enabled(track_index: int) -> void:
	if track_index not in enabled_tracks:
		enabled_tracks.append(track_index)
		
		# Update label if needed
		if enabled_tracks.size() == 1 and label:
			label.text = "Only 1 track is available currently"
		elif label:
			label.text = ""
		
		print("Track ", track_index, " added. Enabled tracks: ", enabled_tracks)
