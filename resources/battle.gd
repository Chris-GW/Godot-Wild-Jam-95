class_name Battle
extends Resource

@export
var enemy: EnemyBattler

@export
var player: PlayerBattler

var _player_effect_history: Array[BattleEffect] = []

func start() -> void:
	_player_effect_history.clear()

	_wait_for_player_choice()

func _on_player_attack_chosen(index: int) -> void:
	_do_player_turn(index)
	_do_enemy_turn()

func _do_player_turn(index: int) -> void:
	var item := Loadout.get_item(index)
	if not item:
		CustomLogger.info("No item at index %d" % index)
		return

	var battle_effect := item.battle_effect
	if battle_effect:
		battle_effect.apply(self)

		if battle_effect.did_apply():
			_player_effect_history.append(battle_effect)

	CustomLogger.info("Player effect history: %d effect(s)" % _player_effect_history.size())

func _do_enemy_turn() -> void:
	if enemy:
		CustomLogger.info("Enemy %s skips their turn" % enemy.name)

	_wait_for_player_choice()

func _wait_for_player_choice() -> void:
	SignalHelper.once(
		GameEvents.player_attack_chosen,
		_on_player_attack_chosen)

	CustomLogger.info("Waiting for player choice...")

func get_last_effect() -> BattleEffect:
	return _player_effect_history.back() if _player_effect_history.size() > 0 else null
