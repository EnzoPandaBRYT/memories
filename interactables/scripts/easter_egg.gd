extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		AudioPlayer._collected()
		Input.start_joy_vibration(0, 0.9, 0.9, 0.5)
		PlayerVars.eggs_catched += 1
		$fade.play("fade_out")
		
