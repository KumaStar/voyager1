extends Control
@onready var musicscreen: Control = $musicscreen
@onready var navigation: Control = $navigation
@onready var desktop: Control = $desktop
@onready var guide: Control = $guide
@onready var query: Control = $query


func _ready() -> void:
	desktop.visible = true
	navigation.visible = false
	musicscreen.visible = false
	query.visible = false
	guide.visible = false
