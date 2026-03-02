extends ProgressBar

var time = 0
var animation_playing = false
var size_x_buffer = PlayerVars.hp_bar_size_x

func _ready() -> void:
	max_value = PlayerVars.hp_bar_max_value

func _process(delta: float) -> void:
	if PlayerVars.player_health > PlayerVars.player_health_buffer:
		PlayerVars.player_health -= 10
	if PlayerVars.player_health < PlayerVars.player_health_buffer:
		PlayerVars.player_health += 20
		
	value = PlayerVars.player_health
	
	if PlayerVars.player_health_buffer <= 300 and !animation_playing:
		animation_playing = true
		$"../health_anim".play("low_health")
		AudioPlayer._low_health()
	elif PlayerVars.player_health_buffer > 300:
		animation_playing = false
		$"../health_anim".play("RESET")
	
	if !PlayerVars.taking_damage:
		if PlayerVars.player_health_buffer < (PlayerVars.player_max_health/2) and PlayerVars.player_stamina > 0:
			time += delta
			if time >= 5.0:
				PlayerVars.player_health_buffer += 10
				PlayerVars.player_stamina_buffer -= 10
	if PlayerVars.taking_damage:
		PlayerVars.taking_damage = false
		time = 0
	
	if PlayerVars.health_upgrade:
		PlayerVars.health_upgrade = false
		$"../health_upgrade".play("upgrade")
		size_x_buffer += 10
		max_value += 100
		PlayerVars.hp_bar_size_x += 10
		PlayerVars.hp_bar_max_value += 100
		PlayerVars.player_max_health += 100
		PlayerVars.player_health_buffer = PlayerVars.player_max_health
	
	if size.x != size_x_buffer:
		size.x += 1

	if Input.is_action_just_pressed("pvz"):
		PlayerVars.health_upgrade = true
