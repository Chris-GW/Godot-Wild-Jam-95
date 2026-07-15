extends Node

const ENEMY_CASSETTE: EnemyBattler = preload("res://resources/enemies/enemy_cassette.tres")
const ENEMY_CDROM: EnemyBattler = preload("res://resources/enemies/enemy_cdrom.tres")
const ENEMY_VHS: EnemyBattler = preload("res://resources/enemies/enemy_vhs.tres")
const ENEMY_VINYLLP: EnemyBattler = preload("res://resources/enemies/enemy_vinyllp.tres")

var _battle_progressor: BattleProgressor = null

func start_example_battle() -> void:
	var battle = Battle.new()

	battle.enemy = ENEMY_VINYLLP
	battle.player = PlayerManager.get_current()

	_battle_progressor = BattleProgressor.new()
	_battle_progressor.battle = battle
	add_child(_battle_progressor)

	_battle_progressor.start()

func _on_battle_ended(_winner: Battler) -> void:
	_battle_progressor = null

func get_current() -> Battle:
	return _battle_progressor.battle if _battle_progressor else null
