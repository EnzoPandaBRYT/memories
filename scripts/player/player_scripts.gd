extends Character

@onready var player_anim = $player_anim

func _idle():
	_stop_movement()
	if PlayerVars.can_control:
		if is_on_floor() or is_on_ceiling():
			_enterState("idle")
		
		if _jump_action and can_jump:
			_change_state(_StateMachine.JUMP)
		
		if !PlayerVars.gravity_inverted:
			if _Input and is_on_floor():
				_change_state(_StateMachine.WALK)
		else:
			if _Input and is_on_ceiling():
				_change_state(_StateMachine.WALK)
	else:
		if is_on_floor() or is_on_ceiling():
			_enterState("idle")

func _walk():
	if PlayerVars.can_control:
		_enterState("walk")
		if _jump_action and can_jump:
			_change_state(_StateMachine.JUMP)
		
		if !_Input:
			_change_state(_StateMachine.IDLE)
	
	
func _jump():
	_enterState("jump")
	player_movement()
	
	if is_on_floor():
		if !_Input:
			if !_jump_action or !can_jump:
				_change_state(_StateMachine.IDLE)
		else:
			if !_jump_action or !can_jump:
				_change_state(_StateMachine.WALK)

	if is_on_ceiling():
		if !_Input:
			if !_jump_action or !can_jump:
				_change_state(_StateMachine.IDLE)
		else:
			if !_jump_action or !can_jump:
				_change_state(_StateMachine.WALK)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("slime"):
		_change_state(_StateMachine.JUMP)
		AudioPlayer._slime_block()
		Input.start_joy_vibration(0, 0.3, 0.3, 0.4)
		if !PlayerVars.gravity_inverted:
			velocity.y = _jump_speed * 7
		else:
			velocity.y = -_jump_speed * 7
	if body.is_in_group("spikes"):
		if PlayerVars.player_health_buffer > 100 and !PlayerVars.taking_damage:
			velocity.y = _jump_speed * 3
			AudioPlayer._hurt()
			Input.start_joy_vibration(0, 0.3, 0.3, 0.4)
			PlayerVars.player_health_buffer -= 100
			PlayerVars.taking_damage = true
		elif PlayerVars.player_health_buffer <= 100:
			# Ao morrer, faz:
			AudioPlayer._blood()
			PlayerVars.player_health_buffer = 0
			Input.start_joy_vibration(0, 0.5, 0.5, 1)
			player_anim.play("player_die")
			await get_tree().create_timer(0.1).timeout
			player_anim.play("player_spawn")
			position.x = PlayerVars.checkpoint_x
			position.y = PlayerVars.checkpoint_y
			PlayerVars.can_control = false
			PlayerVars.died = true
			await get_tree().create_timer(1).timeout
			can_jump = true
			PlayerVars.died = false
			PlayerVars.can_control = true
			PlayerVars.player_health_buffer = PlayerVars.player_max_health
		
	
	if body.is_in_group("invert_gravity"):
		if !PlayerVars.gravity_inverted:
			AudioPlayer._inverted_gravity()
			Input.start_joy_vibration(0, 0.4, 0.4, 0.3)
			PlayerVars.gravity_inverted = true
	
	if body.is_in_group("normalize_gravity"):
		if PlayerVars.gravity_inverted:
			AudioPlayer._normalized_gravity()
			Input.start_joy_vibration(0, 0.4, 0.4, 0.3)
			PlayerVars.gravity_inverted = false
		
	if body.is_in_group("secret_1"):
		$"../ground/secrets/secrets".play("secret_1_reveal")

func _on_area_2d_body_exited(body: Node2D) -> void:
		if body.is_in_group("secret_1"):
			$"../ground/secrets/secrets".play_backwards("secret_1_reveal")
