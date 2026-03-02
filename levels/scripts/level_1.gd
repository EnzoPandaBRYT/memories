extends Node2D

func _ready() -> void:
	PlayerVars.player_health_buffer = PlayerVars.player_max_health
	if PlayerVars.no_campfire_mode:
		$ground/red_bg_animation.speed_scale = 2
		$ground/red_bg_animation.play_backwards("red_bg_moving")
		$ground/red_bg.modulate = Color(0.765, 0.0, 0.345, 1.0)
	PlayerVars.campfires_in_level = 9
	AudioPlayer._memories()
	PlayerVars.can_control = false
	await get_tree().create_timer(1).timeout
	PlayerVars.can_control = true
