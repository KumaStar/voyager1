extends Control
@onready var musicscreen: Control = $"../musicscreen"
@onready var desktop: Control = $"."

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	desktop.visible = false
	musicscreen.visible = true
