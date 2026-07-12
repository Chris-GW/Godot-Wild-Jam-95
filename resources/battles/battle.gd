class_name Battle
extends Resource

@export
var enemy: EnemyBattler

@export
var player: PlayerBattler

var _player_effect_history: Array[BattleEffect] = []
var _enemy_effect_history: Array[BattleEffect] = []

signal ended(winner: Battler)

func start() -> void:
	if not player:
		CustomLogger.warning("Battle does not have a player!")
		return

	if not enemy:
		CustomLogger.warning("Battle does not have an enemy!")
		return

	_player_effect_history.clear()
	_enemy_effect_history.clear()

	_wait_for_player_choice()

func _on_player_attack_chosen(index: int) -> void:
	_do_player_turn(index)

	if _check_ended():
		return

	_do_enemy_turn()

	if _check_ended():
		return

	_wait_for_player_choice()

func _check_ended() -> bool:
	# player wins if the both battlers died at the same time
	if enemy.is_dead():
		ended.emit(player)
		return true

	if player.is_dead():
		ended.emit(enemy)
		return true

	return false

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
	var battle_effect := enemy.battle_effect

	if battle_effect:
		battle_effect.apply(self)

		if battle_effect.did_apply():
			_enemy_effect_history.append(battle_effect)
	else:
		CustomLogger.info("Enemy %s skips their turn" % enemy.name)

	CustomLogger.info("Enemy effect history: %d effect(s)" % _enemy_effect_history.size())

func _wait_for_player_choice() -> void:
	SignalHelper.once(
		GameEvents.player_attack_chosen,
		_on_player_attack_chosen)

	CustomLogger.info("Waiting for player choice...")

func get_last_effect() -> BattleEffect:
	return _player_effect_history.back() if _player_effect_history.size() > 0 else null
