extends Node

var _player: PlayerBattler = preload("res://resources/players/player_default.tres")
var first_wakeup := true

func get_current() -> PlayerBattler:
	return _player
