extends Node

const GAME_START := preload("res://assets/audio/sfx/menu-up-down.mp3")

const MENU_UP_DOWN := preload("res://assets/audio/sfx/menu-up-down.mp3")
const MENU_SELECT := preload("res://assets/audio/sfx/menu-select.mp3")

var _audio_player: AudioStreamPlayer = null

func _ready() -> void:
	_audio_player = AudioStreamPlayer.new()
	add_child.call_deferred(_audio_player)

func play_game_start() -> void:
	if _audio_player:
		_audio_player.stream = GAME_START
		_audio_player.play()

func play_menu_up_down() -> void:
	if _audio_player:
		_audio_player.stream = MENU_UP_DOWN
		_audio_player.play()

func play_menu_select() -> void:
	if _audio_player:
		_audio_player.stream = MENU_SELECT
		_audio_player.play()
