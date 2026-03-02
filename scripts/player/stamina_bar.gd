extends ProgressBar

var time = 0
var can_heal_stamina = false

func _process(delta: float) -> void:
	if PlayerVars.player_stamina > PlayerVars.player_stamina_buffer:
		PlayerVars.player_stamina -= 10
	
	if PlayerVars.player_stamina < PlayerVars.player_stamina_buffer:
		PlayerVars.player_stamina += 1
	
	if PlayerVars.player_stamina_buffer < PlayerVars.player_max_stamina and can_heal_stamina:
		time += delta
		if time >= 5.0:
			PlayerVars.player_stamina_buffer += 1
			
	if PlayerVars.player_stamina >= PlayerVars.player_max_stamina:
		time = 0
	
	if PlayerVars.player_stamina <= 0:
		can_heal_stamina = true
	value = PlayerVars.player_stamina
