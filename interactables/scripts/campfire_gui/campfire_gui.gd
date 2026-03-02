extends CanvasLayer

var animation_started: bool

func _ready() -> void:
	animation_started = false
	

func _process(delta: float) -> void:
	if PlayerVars.changing_levels:
		animation_started = true
	if animation_started:
		$anim.play("fade_out")
