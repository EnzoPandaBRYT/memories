extends Label

var amplitude = 2
var speed = 2.0
var start_y : float

var campfires_reached = 0

func _ready():
	start_y = position.y
	await get_tree().create_timer(3).timeout
	$"../../animation".play("reduce_opacity")

func _process(delta):
	# flutuação
	position.y = start_y + sin(Time.get_ticks_msec() / 1000.0 * speed) * amplitude

func _physics_process(delta: float) -> void:
	if campfires_reached != PlayerVars.campfires_reached:
		$"../../animation".play("green_blink")
		campfires_reached += PlayerVars.campfires_reached - campfires_reached
		text = str(campfires_reached) + "/6"
		await get_tree().create_timer(3).timeout
		$"../../animation".play("reduce_opacity")
