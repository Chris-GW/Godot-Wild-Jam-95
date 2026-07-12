extends Node

var _battle: Battle = null

func _ready() -> void:
	_battle = Battle.new()

	_battle.enemy = preload("res://resources/enemies/enemy_cassette.tres")
	_battle.player = PlayerManager.get_current()

	SignalHelper.once(_battle.ended, _on_battle_ended)

	_battle.start()

func _on_battle_ended(winner: Battler) -> void:
	CustomLogger.info("%s won the battle!" % winner.name)

	_battle = null

func get_current() -> Battle:
	return _battle
