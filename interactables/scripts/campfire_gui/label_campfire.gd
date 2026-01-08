extends Label

var amplitude = 2
var speed = 2.0
var start_y : float

var campfires_reached = 0

var pressed_button = false

func _ready():
	start_y = position.y

func _process(delta):
	# flutuação
	position.y = start_y + sin(Time.get_ticks_msec() / 1000.0 * speed) * amplitude

func _physics_process(delta: float) -> void:
	var controllers_connected := Input.get_connected_joypads().size()
	if campfires_reached != PlayerVars.campfires_reached:
		$"../../animation".play("green_blink")
		campfires_reached += PlayerVars.campfires_reached - campfires_reached
		text = str(campfires_reached) + "/9"

	if Input.is_anything_pressed() and !pressed_button:
		pressed_button = true
		$"../../animation_gui".play("normal_opacity")
		if controllers_connected:
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		return
	if pressed_button:
		$"../../animation_gui".play("reduce_opacity")
		pressed_button = false
		return
