extends Button

var amplitude = 8
var speed = 2.0
var start_position: Vector2

func _ready() -> void:
	start_position = position

func _process(delta):
	# flutuação
	position = start_position + get_global_mouse_position()/50
