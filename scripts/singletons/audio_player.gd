extends AudioStreamPlayer

## Music
const memories_intro = preload("res://audios/ost/Time is now obsolete (INTRO).mp3")
const memories_drums = preload("res://audios/ost/Time is now obsolete (DRUMS).mp3")
const memories_final = preload("res://audios/ost/Time is now obsolete (FINAL).mp3")
const holy_life_intro = preload("res://audios/ost/Holy Life - Intro.mp3")
const holy_life_mid = preload("res://audios/ost/Holy Life - Mid.mp3")
const holy_life_outro = preload("res://audios/ost/Holy Life - Outro.mp3")
const in_honor_intro = preload("res://audios/ost/In Honor (Intro).mp3")
const in_honor_p1 = preload("res://audios/ost/In Honor P1.mp3")
const in_honor_t1 = preload("res://audios/ost/In Honor Transition 1.mp3")
const in_honor_t2 = preload("res://audios/ost/In Honor Transition 2.mp3")
const in_honor_h_i = preload("res://audios/ost/In Honor - Heaven Intro.mp3")
const in_honor_h_l = preload("res://audios/ost/In Honor - Heaven Loop.mp3")
const in_honor_final = preload("res://audios/ost/In Honor - Final Part.mp3")
const ht_i = preload("res://audios/ost/HorrorTale Cover/To Forgive (Intro).mp3")
const ht_m = preload("res://audios/ost/HorrorTale Cover/To Forgive (Mid).mp3")
const ht_f = preload("res://audios/ost/HorrorTale Cover/To Forgive (Final).mp3")

## SFX
const fstep_stone_1 = preload("res://audios/sfx/footstep_stone/footstep_1.mp3")
const fstep_stone_2 = preload("res://audios/sfx/footstep_stone/footstep_2.mp3")
const fstep_stone_3 = preload("res://audios/sfx/footstep_stone/footstep_3.mp3")
const game_saved = preload("res://audios/sfx/saved_game.wav")
const invert_gravity = preload("res://audios/sfx/invert_gravity.wav")
const normalize_gravity = preload("res://audios/sfx/normalized_gravity.mp3")
const teleport_in = preload("res://audios/sfx/teleport_in.mp3")
const teleport_out = preload("res://audios/sfx/teleport_out.mp3")
const loading_wind = preload("res://audios/sfx/Wind.mp3")
const evil_laugh = preload("res://audios/sfx/evil_laugh.mp3")
const correct = preload("res://audios/sfx/correct.mp3")

## Player
const jumping = preload("res://audios/sfx/swoosh.mp3")
const slime_block = preload("res://audios/sfx/slime_block.wav")
const landing = preload("res://audios/sfx/landing.mp3")
const blood = preload("res://audios/sfx/blood.mp3")
const dash = preload("res://audios/sfx/dash.wav")
const hurt = preload("res://audios/sfx/hurt.wav")
const low_health = preload("res://audios/sfx/low_health.mp3")

func _play_music(music: AudioStream, volume = -9.0, actualTime = 0.0):
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()
	seek(actualTime)

# Music
func _holy_life():
	_play_music(holy_life_intro, -5)
	await self.finished
	_play_music(holy_life_mid, -5)

func _holy_life_final():
	_play_music(holy_life_outro, -5)
	
func _memories():
	_play_music(memories_intro, -5)
	await self.finished
	_play_music(memories_drums, -5)

func _memories_final():
	_play_music(memories_final, -5)

func _in_honor_p1_loop():
	_play_music(in_honor_intro, -5)
	await self.finished
	_play_music(in_honor_p1, -5)
	
func _in_honor_transition():
	_play_music(in_honor_t1)
	
func _in_honor_heaven_1():
	_play_music(in_honor_t2)
	await self.finished
	_play_music(in_honor_h_i)
	await self.finished
	_play_music(in_honor_h_l)

func _horrortale():
	_play_music(ht_i)
	await self.finished
	if !PlayerVars.entering_level:
		_play_music(ht_m)
		await self.finished

func _horrortale_final():
	_play_music(ht_f)

#------------------------------
func play_FX(stream: AudioStream, volume = 0.0, pitch = 1.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	fx_player.bus = "SFX" 
	fx_player.pitch_scale = pitch
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	
	fx_player.queue_free()

# SFX
func fstep_stone():
	var rng = randi_range(1,3)
	match rng:
		1:
			play_FX(fstep_stone_1,-5,randf_range(0.96,1.04))
		2:
			play_FX(fstep_stone_2,-5,randf_range(0.96,1.04))
		3:
			play_FX(fstep_stone_1,-5,randf_range(0.96,1.04))

func jump():
	play_FX(jumping, -2, randf_range(0.93,1.03))
	
func _slime_block():
	play_FX(slime_block, -8, randf_range(0.96,1.04))

func _blood():
	play_FX(blood, -6, randf_range(0.93,1.03))

func _collected():
	play_FX(game_saved, -9, randf_range(0.6,0.7))
	
func _saved_game(pitch = randf_range(0.93,1.03)):
	play_FX(game_saved, -9, pitch)

func _dash():
	play_FX(dash, -9, randf_range(0.93,1.03))

func _inverted_gravity():
	play_FX(invert_gravity, -9, randf_range(0.93,1.03))

func _normalized_gravity():
	play_FX(normalize_gravity, -9, randf_range(0.93,1.03))

func _teleport_in():
	play_FX(teleport_in, -9, randf_range(0.95,1.05))

func _teleport_out():
	play_FX(teleport_out, -9, randf_range(0.95,1.05))

func _loading_wind():
	_play_music(loading_wind)

func _evil_laugh():
	play_FX(evil_laugh,-16)

func _correct():
	play_FX(correct, -4)

func _hurt():
	play_FX(hurt, -3, randf_range(0.95, 1.05))

func _low_health():
	play_FX(low_health, 0, randf_range(0.90, 1.1))

func fade_to_music(fade_time := 1.0):
	var tween = create_tween()
	tween.tween_property(self, "volume_db", -80, fade_time) # fade out

func music_reduce(new_volume := -18.0, fade_time := 0.5, pitch = 1.0):
	var tween = create_tween()
	tween.tween_property(self, "volume_db", new_volume, fade_time) # fade out
	tween.tween_property(self, "pitch_scale", pitch, fade_time)

func music_normal(old_volume := -5.0, fade_time := 0.5, pitch = 1.0):
	var tween = create_tween()
	tween.tween_property(self, "volume_db", old_volume, fade_time) # fade out
	tween.tween_property(self, "pitch_scale", pitch, fade_time)
