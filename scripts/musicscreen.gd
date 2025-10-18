extends Control
@onready var desktop: Control = $"../desktop"
@onready var musicscreen: Control = $"."

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	musicscreen.visible = false
	desktop.visible = true
