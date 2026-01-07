extends Node2D

func _ready() -> void:
	AudioPlayer._memories()
	PlayerVars.can_control = false
	await get_tree().create_timer(1).timeout
	PlayerVars.can_control = true
