class_name Battle
extends Resource

@export
var enemy: EnemyBattler

@export
var player: PlayerBattler

var _player_effect_history: Array[EffectAttempt] = []
var _enemy_effect_history: Array[EffectAttempt] = []

var _is_enemy_turn := false
var _enemy_skips := 0
var _enemy_damage_misses := 0

signal event_occurred(text: String)
signal events_occurred(texts: Array[String], battler: Battler)
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

	enemy.heal_fully()

	player.heal_fully()
	player.reset_mana()

	_player_effect_history.clear()
	_enemy_effect_history.clear()

	_is_enemy_turn = false
	_enemy_skips = 0
	_enemy_damage_misses = 0

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
	_is_enemy_turn = false

	var event_texts: Array[String] = []

	var item := Loadout.get_item(index)
	if item:
		var battle_effect := item.battle_effect
		if battle_effect:
			var attempt := battle_effect.apply(self)
			_player_effect_history.append(attempt)

			event_texts.append("Player %s attacked using %s!" % [player.name, item.name])
			event_texts.append_array(attempt.attempt_texts)
		else:
			event_texts.append("Player %s skipped their turn." % player.name)
	else:
		event_texts.append("No item at index %d" % index)

	events_occurred.emit(event_texts, player)

	CustomLogger.debug("Player effect history: %d effect(s)" % _player_effect_history.size())

func do_enemy_turn() -> void:
	_is_enemy_turn = true

	var event_texts: Array[String] = []

	if _enemy_skips > 0:
		event_texts.append("Enemy %s skipped their turn." % enemy.name)
		_enemy_skips -= 1
	else:
		var battle_effect := enemy.battle_effect
		if battle_effect:
			if battle_effect.has_damage() and _enemy_damage_misses > 0:
				event_texts.append("Enemy %s attacked but missed!" % enemy.name)
				_enemy_damage_misses -= 1
			else:
				var attempt := battle_effect.apply(self)
				_enemy_effect_history.append(attempt)

				event_texts.append("Enemy %s attacked!" % enemy.name)
				event_texts.append_array(attempt.attempt_texts)
		else:
			event_texts.append("Enemy %s had no attack!" % enemy.name)

	events_occurred.emit(event_texts, enemy)

	CustomLogger.debug("Enemy effect history: %d effect(s)" % _enemy_effect_history.size())

func add_enemy_skip() -> void:
	_enemy_skips += 1

	CustomLogger.debug("Added enemy skip, total skips: %d" % _enemy_skips)

func add_enemy_damage_miss() -> void:
	_enemy_damage_misses += 1

	CustomLogger.debug("Added enemy damage miss, total damage misses: %d" % _enemy_damage_misses)

func get_last_attempt() -> EffectAttempt:
	return _player_effect_history.back() if _player_effect_history.size() > 0 else null

func is_enemy_turn() -> bool:
	return _is_enemy_turn
