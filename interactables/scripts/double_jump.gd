extends Node2D

var amplitude = 4
var speed = 2.0
var start_y : float

func _ready():
	start_y = position.y

func _process(delta):
	# flutuação
	position.y = start_y + sin(Time.get_ticks_msec() / 1000.0 * speed) * amplitude
	
	# pulsar escala
	var scale_factor = 1.0 + (sin(Time.get_ticks_msec() / 1000.0 * speed) * 0.05) # varia entre 0.9 e 1.1
	scale = Vector2(scale_factor, scale_factor)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		PlayerVars.max_jumps = 2
		PlayerVars.jumps = 2
		AudioPlayer._collected()
		queue_free()
