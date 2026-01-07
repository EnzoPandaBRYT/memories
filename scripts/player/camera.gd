extends Camera2D

@onready var camera_anim = $"../camera_anim"

var zoom_out := false
var animation_finished := true

var mouse_offset_x = 0.0
var mouse_offset_y = 0.0

func _physics_process(delta: float) -> void:
	mouse_offset_x = get_local_mouse_position().x
	mouse_offset_y = get_local_mouse_position().y
	
	if Input.is_action_pressed("camera_offset"):
		if Input.get_connected_joypads().size() > 0:
			offset = get_look_dir()
		else:
			offset = Vector2(mouse_offset_x/5,-mouse_offset_y/5)
	if Input.is_action_just_released("camera_offset"):
		offset = Vector2(0.0,0.0)
	
	if Input.is_action_just_pressed("camera_change") and !zoom_out and animation_finished:
		animation_finished = false
		zoom_out = true
		camera_anim.play("zoom_out")
		AudioPlayer.music_reduce(-10)
		return
	if Input.is_action_just_pressed("camera_change") and zoom_out and animation_finished:
		animation_finished = false
		zoom_out = false
		camera_anim.play("zoom_in")
		AudioPlayer.music_normal(-5)
		return

func _on_camera_anim_animation_finished(anim_name: StringName) -> void:
	animation_finished = true

func get_look_dir() -> Vector2:
	var dir := Vector2(
		Input.get_action_strength("look_right") - Input.get_action_strength("look_left"),
		Input.get_action_strength("look_down") - Input.get_action_strength("look_up")
	)
	
	return dir.normalized() * 60
