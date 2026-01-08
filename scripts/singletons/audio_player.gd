extends AudioStreamPlayer

## Music
const memories_intro = preload("res://audios/ost/Time is now obsolete (INTRO).mp3")
const memories_drums = preload("res://audios/ost/Time is now obsolete (DRUMS).mp3")

## SFX
const fstep_stone_1 = preload("res://audios/sfx/footstep_stone/footstep_1.mp3")
const fstep_stone_2 = preload("res://audios/sfx/footstep_stone/footstep_2.mp3")
const fstep_stone_3 = preload("res://audios/sfx/footstep_stone/footstep_3.mp3")
const game_saved = preload("res://audios/sfx/saved_game.wav")
const invert_gravity = preload("res://audios/sfx/invert_gravity.wav")
const normalize_gravity = preload("res://audios/sfx/normalized_gravity.mp3")

## Player
const jumping = preload("res://audios/sfx/swoosh.mp3")
const slime_block = preload("res://audios/sfx/slime_block.wav")
const landing = preload("res://audios/sfx/landing.mp3")
const blood = preload("res://audios/sfx/blood.mp3")
const dash = preload("res://audios/sfx/dash.wav")


func _play_music(music: AudioStream, volume = -9.0, actualTime = 0.0):
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()
	seek(actualTime)

# Music
func _memories():
	_play_music(memories_intro, -5)
	await self.finished
	_play_music(memories_drums, -5)


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
