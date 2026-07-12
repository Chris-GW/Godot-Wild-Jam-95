extends Node

var _player: PlayerBattler = preload("res://resources/players/player_default.tres")

func get_current() -> PlayerBattler:
	return _player
