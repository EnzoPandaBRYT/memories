extends AnimationPlayer

var trying_to_escape = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") and not trying_to_escape:
		trying_to_escape = true
		play("blink")
		await get_tree().create_timer(1).timeout
		trying_to_escape = false
	
	if PlayerVars.changing_levels:
		PlayerVars.can_control = false
		play("teleport_in")
	
	if PlayerVars.new_level:
		PlayerVars.new_level = false
		play("teleport_out")

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "teleport_in":
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://gui/scenes/loading_screen.tscn")
	if anim_name == "blink":
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://gui/scenes/main_menu.tscn")
		
