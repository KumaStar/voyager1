extends Node2D

@export var panel_width := 500
@export var panel_height := 200
@export var scroll_speed := 40.0  # pixels per second
@export var glitch_chance := 0.3
@export var glitch_max_offset := 10.0

var pixels := []  # each element is a float representing amplitude at that column
var scroll_accumulator := 0.0

func _ready():
	pixels.resize(panel_width)
	for i in range(panel_width):
		pixels[i] = 0.0
	randomize()

func _process(delta):
	scroll_accumulator += scroll_speed * delta
	while scroll_accumulator >= 1.0:
		# Shift all pixels left
		for i in range(panel_width - 1):
			pixels[i] = pixels[i + 1]
		# Add new pixel at right
		pixels[panel_width - 1] = randf() * panel_height  # replace with audio FFT later
		scroll_accumulator -= 1.0
	queue_redraw()

# Heatmap mapping: 0..1 -> color
func heatmap_color(t: float) -> Color:
	t = clamp(t, 0.0, 1.0)
	if t < 0.25:
		return Color(0, 0, lerp(0.5,1.0,t/0.25)) # dark blue → blue
	elif t < 0.5:
		return Color(0, lerp(0,1,(t-0.25)/0.25),1) # blue → cyan
	elif t < 0.75:
		return Color(lerp(0,1,(t-0.5)/0.25),1,0) # cyan → green→yellow
	else:
		return Color(1, lerp(1,0,(t-0.75)/0.25),0) # yellow → red

func _draw():
	# Draw as a connected spectrogram
	for x in range(panel_width):
		var h = pixels[x]
		var intensity = h / panel_height
		var color = heatmap_color(intensity)
		
		# Draw vertical line connecting to previous height (for connected effect)
		var prev_y = panel_height - pixels[max(x-1,0)]
		draw_line(Vector2(x-1, prev_y), Vector2(x, panel_height - h), color, 1.0)
		
		# Glitch overlay
		if randf() < glitch_chance:
			var y_offset = randf_range(-glitch_max_offset, glitch_max_offset)
			draw_line(Vector2(x, panel_height - h), Vector2(x, panel_height - h + y_offset), color, 1.0)
