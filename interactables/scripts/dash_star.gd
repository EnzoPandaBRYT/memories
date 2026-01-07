extends Area2D

var amplitude = 2
var speed = 2.0
var start_y : float

func _ready():
	start_y = position.y

func _process(delta):
	# flutuação
	position.y = start_y + sin(Time.get_ticks_msec() / 1000.0 * speed) * amplitude

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		AudioPlayer._dash()
		PlayerVars.external_force = PlayerVars.last_dir * 500
		if !PlayerVars.gravity_inverted:
			body.velocity.y -= 400
		else:
			body.velocity.y += 400
		await get_tree().create_timer(0.2).timeout
		PlayerVars.external_force = 0.0
		
