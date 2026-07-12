class_name Battle
extends Resource

@export
var enemy: EnemyBattler

@export
var player: PlayerBattler

var _player_effect_history: Array[EffectAttempt] = []
var _enemy_effect_history: Array[EffectAttempt] = []

signal event_occurred(text: String)
signal ended(winner: Battler)

func try_start() -> bool:
	if not player:
		event_occurred.emit("Battle does not have a player!")
		ended.emit(null)
		return false

	if not enemy:
		event_occurred.emit("Battle does not have an enemy!")
		ended.emit(null)
		return false

	_player_effect_history.clear()
	_enemy_effect_history.clear()

	return true

func check_ended() -> bool:
	# player wins if the both battlers died at the same time
	if enemy.is_dead():
		event_occurred.emit("Enemy %s died!" % enemy.name)
		ended.emit(player)
		return true

	if player.is_dead():
		event_occurred.emit("Player %s died!" % player.name)
		ended.emit(enemy)
		return true

	return false

func do_player_turn(index: int) -> void:
	var event_text := ""

	var item := Loadout.get_item(index)
	if item:
		var battle_effect := item.battle_effect
		if battle_effect:
			var attempt := battle_effect.apply(self)
			_player_effect_history.append(attempt)

			event_text = "Player %s attacked using %s! %s" % [player.name, item.name, attempt.attempt_text]
		else:
			event_text = "Player %s skipped their turn." % player.name
	else:
		event_text = "No item at index %d" % index

	event_occurred.emit(event_text)

	CustomLogger.debug("Player effect history: %d effect(s)" % _player_effect_history.size())

func do_enemy_turn() -> void:
	var event_text := ""
	var battle_effect := enemy.battle_effect

	if battle_effect:
		var attempt := battle_effect.apply(self)
		_enemy_effect_history.append(attempt)

		event_text = "Enemy %s attacked! %s" % [enemy.name, attempt.attempt_text]
	else:
		event_text = "Enemy %s skipped their turn." % enemy.name

	event_occurred.emit(event_text)

	CustomLogger.debug("Enemy effect history: %d effect(s)" % _enemy_effect_history.size())

func get_last_attempt() -> EffectAttempt:
	return _player_effect_history.back() if _player_effect_history.size() > 0 else null
