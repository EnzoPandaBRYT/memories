class_name Character extends CharacterBody2D


enum _StateMachine { IDLE, WALK, JUMP }

var _state: _StateMachine # O número aqui retorna um valor do StateMachine, começando em 0
var _enter_state := true

@onready var _animated_sprite = $anim

var _Input: float: # Sistema de Input (Exclusivo do(s) jogador(es)
	get: return Input.get_axis("move_left", "move_right")
	
var _ReverseInput: float: # Sistema de Input (Exclusivo do(s) jogador(es)
	get: return Input.get_axis("move_left", "move_right") * -1

var _VerticalInput: float:
	get: return Input.get_axis("move_down", "move_up")

var _jump_action: bool:
	get: return Input.is_action_just_pressed("jump")

var _player_speed = 100
var _jump_speed = -100.0

var can_jump = true
var footstep_playing = false

func _physics_process(delta: float) -> void:
	match _state: # State machine que, de acordo com o Enum, executa uma função
		_StateMachine.IDLE: _idle()
		_StateMachine.WALK: _walk()
		_StateMachine.JUMP: _jump()
	
	if PlayerVars.can_control:
		_set_Gravity(delta) # Gravidade que usa o parâmetro "delta"
		player_movement() # Movimentação do personagem
		move_and_slide()
		_reset_char()
	
	if is_on_floor() or is_on_ceiling(): 
		if _state == 1 and !footstep_playing:
			footstep_playing = true
			AudioPlayer.fstep_stone()
			await get_tree().create_timer(0.5).timeout
			footstep_playing = false
	

func _enterState(animation: String) -> void: # Em suma, toca a animação que coloca lá no player.gd
	if _enter_state:
		_enter_state = false
		_animated_sprite.play(animation)

func _change_state(new_state: _StateMachine) -> void:
	if _state != new_state:
		_state = new_state
		_enter_state = true

# Estados possíveis do Player
func _idle() -> void: pass
func _walk() -> void: pass
func _jump() -> void: pass

func _stop_movement():
	velocity.x = 0

func player_movement():
	if PlayerVars.external_force != 0:
		velocity.x = PlayerVars.last_dir * _player_speed + PlayerVars.external_force
		
	if _Input:
		PlayerVars.last_dir = _Input
		velocity.x = sign(_Input) * _player_speed + PlayerVars.external_force
	
	if _Input > 0:
		_animated_sprite.flip_h = false
	if _Input < 0:
		_animated_sprite.flip_h = true
		
	if _jump_action and can_jump and PlayerVars.jumps != 0:
		AudioPlayer.jump()
		if !PlayerVars.gravity_inverted:
			if PlayerVars.max_jumps > 1:
				match PlayerVars.jumps:
					2:
						velocity.y = _jump_speed * 3
					1:
						velocity.y = _jump_speed * 2.5
			else:
				velocity.y = _jump_speed * 3
		else:
			if PlayerVars.max_jumps > 1:
				match PlayerVars.jumps:
					2:
						velocity.y = -_jump_speed * 3
					1:
						velocity.y = -_jump_speed * 2.5
			else:
				velocity.y = _jump_speed * 3
		PlayerVars.jumps -= 1
		can_jump = false
		await get_tree().create_timer(0.1).timeout
		can_jump = true
		
	if is_on_floor() and !PlayerVars.gravity_inverted:
		PlayerVars.jumps = PlayerVars.max_jumps
	
	if is_on_ceiling() and PlayerVars.gravity_inverted:
		PlayerVars.jumps = PlayerVars.max_jumps
	
func _set_Gravity(delta: float) -> void:
	if PlayerVars.gravity_inverted:
		if !is_on_ceiling():
			velocity += (get_gravity() * delta) * -1
			scale.y = -1
	else:
		if !is_on_floor() or is_on_ceiling():
			velocity += get_gravity() * delta # Gravidade
			scale.y = 1

func _reset_char():
	if Input.is_action_just_pressed("reset_char"):
		AudioPlayer._blood()
		await get_tree().create_timer(0.1).timeout
		position.x = PlayerVars.checkpoint_x
		position.y = PlayerVars.checkpoint_y
		PlayerVars.can_control = false
		PlayerVars.died = true
		await get_tree().create_timer(1).timeout
		can_jump = true
		PlayerVars.died = false
		PlayerVars.can_control = true
