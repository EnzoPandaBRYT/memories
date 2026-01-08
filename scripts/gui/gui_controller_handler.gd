extends Node2D

@onready var jump_button_xbox = $"A-button"
@onready var jump_button_pc = $"UpArrow"
@onready var zoom_button_xbox = $"X-button"
@onready var zoom_button_pc = $"ShiftButton"

var controllers_connected = Input.get_connected_joypads().size()

func _physics_process(delta: float) -> void:
	if controllers_connected:
		jump_button_pc.visible = false
		zoom_button_pc.visible = false
		jump_button_xbox.visible = true
		zoom_button_xbox.visible = true
	else:
		jump_button_pc.visible = true
		zoom_button_pc.visible = true
		jump_button_xbox.visible = false
		zoom_button_xbox.visible = false
