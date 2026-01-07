extends AnimationPlayer

var trying_to_escape = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") and not trying_to_escape:
		trying_to_escape = true
		play("blink")
		await get_tree().create_timer(1).timeout
		trying_to_escape = false
