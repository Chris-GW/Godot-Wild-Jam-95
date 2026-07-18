extends Node

const ENEMY_CASSETTE: EnemyBattler = preload("res://resources/enemies/enemy_cassette.tres")
const ENEMY_CDROM: EnemyBattler = preload("res://resources/enemies/enemy_cdrom.tres")
const ENEMY_VHS: EnemyBattler = preload("res://resources/enemies/enemy_vhs.tres")
const ENEMY_VINYLLP: EnemyBattler = preload("res://resources/enemies/enemy_vinyllp.tres")
const ENEMY_CRTTV: EnemyBattler = preload("res://resources/enemies/enemy_crttv.tres")

var _battle_progressor: BattleProgressor = null
var _current_encounter: Encounter = null

func _ready() -> void:
	SignalHelper.persist(
		GameEvents.battle_ended,
		_on_battle_ended)

func start_encounter(encounter: Encounter) -> void:
	if not encounter:
		return

	_current_encounter = encounter

	CustomLogger.info("Starting encounter with enemy %s" % _current_encounter.enemy.name)

	var battle = Battle.new()

	battle.enemy = _current_encounter.enemy
	battle.player = PlayerManager.get_current()

	_battle_progressor = BattleProgressor.new()
	_battle_progressor.battle = battle
	assert(_battle_progressor != null)
	add_child(_battle_progressor)

	_battle_progressor.start()

func _on_battle_ended(is_won: bool) -> void:
	_battle_progressor = null

	if _current_encounter:
		_current_encounter.finish(is_won)

	_current_encounter = null

func get_current() -> Battle:
	return _battle_progressor.battle if _battle_progressor else null
