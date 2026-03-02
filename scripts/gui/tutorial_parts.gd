extends Node

var tutorial_step = 0
# 0 = Jump Tutorial
# 1 = Spike Tutorial
# 2 = Slime Tutorial

func _ready() -> void:
	tutorial_step = 0
	$tutorial_steps.play("bg_fade_in")
	await get_tree().create_timer(1.1).timeout
	$tutorial_gui/jump.visible = true
	$tutorial_steps.play("text_fade_in")

func _process(delta: float) -> void:
	match tutorial_step:
		0:
			if Input.is_action_just_pressed("jump"):
				$tutorial_steps.play("jump_blink")
				AudioPlayer._correct()
				tutorial_step = 1
		1:
			if PlayerVars.player_health == 0:
				$tutorial_steps.play("die_blink")
				AudioPlayer._correct()
				tutorial_step = 2
