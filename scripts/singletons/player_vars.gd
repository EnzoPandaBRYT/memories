extends Node

# Pode controlar o The Man?
var can_control = true
var died = false

# Posições que irá voltar caso morra
var checkpoint_x = 25.0
var checkpoint_y = 410.0

# Poderes
var jumps = 1
var max_jumps = 1
var gravity_inverted = false

# Infos para o Dash
var last_dir = 0.0
var external_force = 0.0

var campfires_reached = 0
