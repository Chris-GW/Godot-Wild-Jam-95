extends Node

var _battle: Battle = null

func _ready() -> void:
	_battle = Battle.new()

	_battle.enemy = preload("res://resources/enemies/enemy_cassette.tres")
	_battle.player = PlayerBattler.new()

	_battle.start()

func get_current() -> Battle:
	return _battle
