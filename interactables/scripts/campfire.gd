extends Area2D

func _ready() -> void:
	$saved.visible = false

func _on_body_entered(body: Node2D) -> void:
	if PlayerVars.checkpoint_x != position.x and PlayerVars.checkpoint_y != position.y:
		PlayerVars.campfires_reached += 1
		$animation.play("saved_game")
		AudioPlayer._saved_game()
		if !PlayerVars.gravity_inverted:
			PlayerVars.checkpoint_x = position.x
			PlayerVars.checkpoint_y = position.y - 40
		else:
			PlayerVars.checkpoint_x = position.x
			PlayerVars.checkpoint_y = position.y + 40
		
