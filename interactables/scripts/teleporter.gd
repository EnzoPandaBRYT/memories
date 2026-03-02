extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" and !PlayerVars.changing_levels:
		match PlayerVars.level:
			0: AudioPlayer._holy_life_final()
			1: AudioPlayer._memories_final()
			
		AudioPlayer.music_reduce(-30, 4.0)
		AudioPlayer._teleport_in()
		PlayerVars.changing_levels = true
		PlayerVars.level += 1
		print(PlayerVars.level)
