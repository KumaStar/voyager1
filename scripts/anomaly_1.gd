extends Area2D

# Signal to emit when clicked
signal anomaly_clicked

func _ready():
	# Optional: make anomaly visible for debugging
	$CollisionShape2D.shape.extents = Vector2(20, 20)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Anomaly clicked!")
		emit_signal("anomaly_clicked")
		# TODO: trigger buzzer, unlock symbol, etc.
