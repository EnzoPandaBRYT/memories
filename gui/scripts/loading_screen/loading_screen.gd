extends Control

func _ready() -> void:
	AudioPlayer._loading_wind()
	var rng = randf_range(4,6)
	PlayerVars.changing_levels = false
	PlayerVars.can_control = true
	if PlayerVars.level == 1:
		AudioPlayer.music_reduce(-18, rng - 0.5)
		await get_tree().create_timer(rng).timeout
		PlayerVars.new_level = true
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://levels/scenes/level_1.tscn")
	
	if PlayerVars.level == 2:
		await get_tree().create_timer(rng).timeout
		await get_tree().process_frame # Evita a "tela cinza" antes da cena carregar
		get_tree().change_scene_to_file("res://levels/scenes/level_2.tscn")
