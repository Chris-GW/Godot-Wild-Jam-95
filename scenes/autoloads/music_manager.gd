extends Node

var _audio_player: AudioStreamPlayer = null

func _ready() -> void:
	_audio_player = AudioStreamPlayer.new()
	add_child.call_deferred(_audio_player)

func play_encounter_music(stream: AudioStream) -> void:
	if _audio_player:
		_audio_player.stream = stream
		_audio_player.play()

func stop_music() -> void:
	if _audio_player and _audio_player.playing:
		_audio_player.stream = null
		_audio_player.stop()
