extends Control

var controller_conected = 0

var playing = false
var no_modifiers = true

# Modos possíveis:
var campfireless = false
var double_speed = false
var half_gravity = false

func _ready() -> void:
	controller_conected = Input.get_connected_joypads().size()
	if controller_conected > 0:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
		$menu_options/play.grab_focus()
	PlayerVars.level_selected = false
	AudioPlayer._horrortale()
	$menu_options/play.visible = true
	$menu_options/back.visible = false

func _process(delta: float) -> void:
	controller_conected = Input.get_connected_joypads().size()
	var modifiers := []

	if campfireless:
		modifiers.append("- Sem fogueiras")
	if double_speed:
		modifiers.append("- Dobro de velocidade")
	if half_gravity:
		modifiers.append("- Gravidade dividida")

	if modifiers.is_empty():
		no_modifiers = true
		$TheAbyss/modifiers_label.text = "Sem modificadores"
	else:
		no_modifiers = false
		$TheAbyss/modifiers_label.text = "Modificadores:\n" + "\n".join(modifiers)
		no_modifiers = false
		
	if no_modifiers:
		$TheAbyss/modifiers_label.text = "Sem modificadores"
	
	if playing:
		if Input.is_action_just_pressed("ui_up") and !PlayerVars.level_selected and playing:
			$TheAbyss/play.grab_focus()
			$levels.play("level_1_select")
			PlayerVars.level_selected = true
			$menu_options/back.disabled = true
		
		elif Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("escape") and PlayerVars.level_selected and playing:
			$menu_options/back.grab_focus()
			$levels.play("level_1_deselect")
			$menu_options/back.disabled = false
			await get_tree().create_timer(0.5).timeout
			PlayerVars.level_selected = false
		

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		get_tree().change_scene_to_file("res://gui/scenes/loading_screen.tscn")

func _on_play_the_abyss_pressed() -> void:
	Input.start_joy_vibration(0, 1.0, 1.0, 2)
	if campfireless or double_speed or half_gravity:
		AudioPlayer._evil_laugh()
	$TheAbyss/play.disabled = true
	$anim.play("fade_out")
	AudioPlayer._horrortale_final()

func _on_play_main_menu_pressed() -> void:
	$menu_options/back.grab_focus()
	PlayerVars.level = 1
	playing = true
	$main_menu.play("goto_select")
	$menu_options/play.visible = false
	$menu_options/back.visible = true

func _on_back_main_menu_pressed() -> void:
	$menu_options/play.grab_focus()
	playing = false
	$main_menu.play("back_to_main_menu")
	$menu_options/play.visible = true
	$menu_options/back.visible = false

func _on_campfireless_toggled(toggled_on: bool) -> void:
	if toggled_on:
		PlayerVars.no_campfire_mode = true
		campfireless = true
	else:
		PlayerVars.no_campfire_mode = false
		campfireless = false

func _on_double_speed_toggled(toggled_on: bool) -> void:
	if toggled_on:
		PlayerVars.player_speed = 200.0
		double_speed = true
	else:
		PlayerVars.player_speed = 100.0
		double_speed = false


func _on_half_gravity_toggled(toggled_on: bool) -> void:
	if toggled_on:
		PlayerVars.gravity_modifier = 2
		half_gravity = true
	else:
		PlayerVars.gravity_modifier = 1
		half_gravity = false

func _on_quit_game_pressed() -> void:
	get_tree().quit()
