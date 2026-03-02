extends Node2D

func _ready() -> void:
	PlayerVars.campfires_in_level = 0
	PlayerVars.campfires_reached = 0
	PlayerVars.eggs_in_level = 0
	PlayerVars.eggs_catched = 0
	PlayerVars.checkpoint_x = 134.0
	PlayerVars.checkpoint_y = 356.0
	AudioPlayer._teleport_out()
	AudioPlayer._holy_life()
