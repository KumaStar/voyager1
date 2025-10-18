extends Sprite2D

@export var scroll_speed := 50.0  # pixels per second

var start_position := Vector2.ZERO

func _ready():
	# store starting position
	start_position = position

func _process(delta):
	# move left
	position.x -= scroll_speed * delta
	
	# loop if needed (optional)
	if position.x + texture.get_width() < 0:
		position.x = start_position.x
