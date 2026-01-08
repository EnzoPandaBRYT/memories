extends Camera2D

@onready var camera_anim = $"../camera_anim"

var animation_finished := true

var mouse_offset_x = 0.0
var mouse_offset_y = 0.0

func _physics_process(delta: float) -> void:
	mouse_offset_x = get_local_mouse_position().x
	mouse_offset_y = -get_local_mouse_position().y
	
	if Input.is_action_pressed("camera_offset"):
		PlayerVars.looking_around = true
		zoom = Vector2(1.5,1.5)
		if Input.get_connected_joypads().size() > 0:
			offset = get_look_dir()
		else:
			offset = Vector2(mouse_offset_x/3,-mouse_offset_y/3)
	if Input.is_action_just_released("camera_offset"):
		PlayerVars.looking_around = false
		offset = Vector2(0.0,0.0)
		if !PlayerVars.zoom_out:
			zoom = Vector2(3.0,3.0)
	
	if Input.is_action_just_pressed("camera_change") and !PlayerVars.zoom_out and animation_finished:
		animation_finished = false
		PlayerVars.zoom_out = true
		camera_anim.play("zoom_out")
		return
	
	if Input.is_action_just_pressed("camera_change") and PlayerVars.zoom_out and animation_finished:
		animation_finished = false
		PlayerVars.zoom_out = false
		camera_anim.play("zoom_in")
		return

func _on_camera_anim_animation_finished(anim_name: StringName) -> void:
	animation_finished = true

func get_look_dir() -> Vector2:
	var dir := Vector2(
		Input.get_action_strength("look_right") - Input.get_action_strength("look_left"),
		Input.get_action_strength("look_down") - Input.get_action_strength("look_up")
	)
	
	return dir.normalized() * 60
