extends Area2D



func _on_body_entered(body: Node2D) -> void:
	PlayerVars.slowed = true
	body._player_speed = 50
	body._animated_sprite.speed_scale = 0.5
	AudioPlayer.music_reduce(-5, 0.5, 0.9)
	$"../../ground/red_bg_animation".speed_scale = 0.75
