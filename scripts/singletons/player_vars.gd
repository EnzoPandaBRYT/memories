extends Node

# Características do jogador
var player_speed = 100.0
var player_health = 500.0
var player_health_buffer = 500.0
var player_max_health = 500.0
var player_stamina = 600.0
var player_stamina_buffer = 600.0
var player_max_stamina = 600.0
var health_upgrade = false
var gravity_modifier = 1

# Pode controlar o The Man?
var can_control = true
var died = false
var slowed = false
var taking_damage = false

## Checkpoints iniciais:
# Devem ser definidos no INÍCIO de cada nível
var checkpoint_x = 25.0
var checkpoint_y = 410.0

# Poderes
var jumps = 1
var max_jumps = 1
var gravity_inverted = false
var double_jump_unlocked = false

# Infos para o Dash
var last_dir = 0.0
var external_force = 0.0

# Fogueiras
var campfires_in_level = 9
var campfires_reached = 0

# Easter Eggs
var eggs_in_level = 3
var eggs_catched = 0

# Zoom da camera
var zoom_out := false
var looking_around := false

# Infos para níveis
var level = 0
var changing_levels = false
var new_level = false
var level_selected = false
var entering_level = false
var no_campfire_mode = false

# Infos para barra de vida e stamina
var hp_bar_size_x = 50
var hp_bar_max_value = 500
var sp_bar_size_x = 60
