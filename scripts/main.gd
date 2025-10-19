extends Node2D

@onready var computer: Control = $CanvasLayer/Computer
var time_passed := 0.0

func _process(delta):
	time_passed += delta
	if material:
		material.set_shader_parameter("time", time_passed)
