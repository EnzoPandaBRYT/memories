extends Label

var amplitude = 2
var speed = 2.0
var start_y : float

func _ready():
	start_y = position.y

func _process(delta):
	# flutuação
	position.y = start_y + sin(Time.get_ticks_msec() / 1000.0 * speed) * amplitude
	
	if PlayerVars.zoom_out:
		$".".text = "= Voltar ao normal"
	else:
		$".".text = "= Mudar zoom"
	
	if PlayerVars.max_jumps > 1:
		match PlayerVars.jumps:
			0:
				$"../jump".text = "= Pular"
				$"../jump".add_theme_color_override("font_color", "red")
			1:
				$"../jump".text = "= Pular no ar"
			2:
				$"../jump".text = "= Pular"
				$"../jump".add_theme_color_override("font_color", "white")
	
	if PlayerVars.looking_around:
		$"../look_around".text = "= Voltar ao jogador"
	else:
		$"../look_around".text = "= Olhar em volta"
	
	if PlayerVars.can_control:
		$"../restart".text = "= Voltar ao Checkpoint"
		$"../restart".add_theme_color_override("font_color", "white")
	else:
		$"../restart".text = "= Renascendo..."
		$"../restart".add_theme_color_override("font_color", "red")
		$"../jump".add_theme_color_override("font_color", "red")
