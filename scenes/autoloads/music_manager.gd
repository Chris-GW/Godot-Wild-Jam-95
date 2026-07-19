extends Node

var _audio_player: AudioStreamPlayer = null


func _ready() -> void:
	_audio_player = AudioStreamPlayer.new()
	_audio_player.bus = "music"
	add_child.call_deferred(_audio_player)


func play_encounter_music(stream: AudioStream) -> void:
	if _audio_player:
		_audio_player.stream = stream
		_audio_player.play()

func stop_music(music_fade_duration := 1.5) -> void:
	if _audio_player and _audio_player.playing:
		var tween = create_tween()
		tween.tween_property(_audio_player, "volume_db", -60.0, music_fade_duration)
		
		await tween.finished
		_audio_player.stream = null
		_audio_player.stop()
		_audio_player.volume_db = 0.0
