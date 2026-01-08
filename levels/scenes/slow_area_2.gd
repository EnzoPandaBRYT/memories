extends Area2D

func _on_body_entered(body: Node2D) -> void:
	AudioPlayer.music_reduce(-5, 1, 0.75)
	$"../../ground/red_bg_animation".speed_scale = 0.5
