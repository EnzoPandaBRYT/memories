extends Node2D

@onready var jump_button_xbox = $"controls/A-button"
@onready var jump_button_pc = $controls/UpArrow
@onready var zoom_button_xbox = $"controls/X-button"
@onready var zoom_button_pc = $controls/ShiftButton
@onready var look_around_xbox = $controls/RightTrigger
@onready var look_around_pc = $controls/CtrlButton
@onready var restart_button_xbox = $"controls/Back-button"
@onready var restart_button_pc = $controls/RButton

var end_reached = false

func _ready() -> void:
	if PlayerVars.no_campfire_mode:
		$anim/GPUParticles2D.lifetime = 0.5
		$anim/GPUParticles2D.amount = 12
		$anim.play("unlit_campfire")

func _physics_process(delta: float) -> void:
	var controllers_connected = Input.get_connected_joypads().size()
	if controllers_connected:
		jump_button_pc.visible = false
		zoom_button_pc.visible = false
		look_around_pc.visible = false
		restart_button_pc.visible = false
		jump_button_xbox.visible = true
		zoom_button_xbox.visible = true
		look_around_xbox.visible = true
		restart_button_xbox.visible = true
	else:
		jump_button_pc.visible = true
		zoom_button_pc.visible = true
		look_around_pc.visible = true
		restart_button_pc.visible = true
		jump_button_xbox.visible = false
		zoom_button_xbox.visible = false
		look_around_xbox.visible = false
		restart_button_xbox.visible = false
	
