extends Node

var sounds_path = "res://Music/"

var sounds = {
	"grass_step" : load(sounds_path + "grass_step.ogg"),
	"hit" : load(sounds_path + "meleeFx.wav")
}

@onready var sound_players = get_children()

func play(sound_string, pitch_scale = randf_range(0.75, 1.25), volume_db = 0):
	for soundPlayer in sound_players:
		if not soundPlayer.playing:
			soundPlayer.pitch_scale = pitch_scale
			soundPlayer.volume_db = volume_db
			soundPlayer.stream = sounds[sound_string]
			soundPlayer.play()
			return
	print("Too many sounds playing at once")
