extends Area2D

func _ready() -> void:
	$saved.visible = false
	if PlayerVars.no_campfire_mode:
		$collision.disabled = true
		$GPUParticles2D.lifetime = 0.5
		$GPUParticles2D.amount = 12
		$anim.play("unlit_campfire")
		
func _on_body_entered(body: Node2D) -> void:
	if PlayerVars.checkpoint_x != position.x and PlayerVars.checkpoint_y != position.y:
		if PlayerVars.player_max_health >= 1000:
			# Com a vida abaixo ou igual a 300, recebe 500 de cura.
			if PlayerVars.player_health_buffer <= 300:
				PlayerVars.player_health_buffer += 500
			# Com a vida abaixo ou igual a 400, porém maior que 300, recebe 400 de cura.
			if PlayerVars.player_health_buffer <= 400 and PlayerVars.player_health_buffer > 300:
				PlayerVars.player_health_buffer += 400
			# Com a vida abaixo de 1000, porém até 500, recebe 300 de cura.
			if PlayerVars.player_health_buffer < 1000 and PlayerVars.player_health_buffer >= 500:
				PlayerVars.player_health_buffer += 100
		else:
			if PlayerVars.player_health_buffer <= 400:
				PlayerVars.player_health_buffer += 100
		Input.start_joy_vibration(0, 0.1, 0.1, 0.5)
		PlayerVars.campfires_reached += 1
		$animation.play("saved_game")
		AudioPlayer._saved_game()
		
		if !PlayerVars.gravity_inverted:
			PlayerVars.checkpoint_x = position.x
			PlayerVars.checkpoint_y = position.y - 40
		else:
			PlayerVars.checkpoint_x = position.x
			PlayerVars.checkpoint_y = position.y + 40
		
