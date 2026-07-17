class_name Battle
extends Resource

@export
var enemy: EnemyBattler

@export
var player: PlayerBattler

var _player_effect_history: Array[EffectAttempt] = []
var _enemy_effect_history: Array[EffectAttempt] = []

var _is_enemy_turn := false
var _next_enemy_effect: BattleEffect = null
var _enemy_skips := 0
var _enemy_damage_misses := 0

var _enemy_queued_effects: Array[BattleEffect] = []

signal event_occurred(text: String)
signal events_occurred_enemy_first_phase(texts: Array[String], battler: Battler)
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
	_next_enemy_effect = null
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

func resolve_enemy_attack() -> void:
	_next_enemy_effect = enemy.battle_effect.resolve_effect()
	GameEvents.emit_enemy_effect_resolved(_next_enemy_effect)

func do_player_turn(index: int) -> void:
	_is_enemy_turn = false

	var event_texts: Array[String] = []

	var item := Loadout.get_item(index)
	if item:
		var battle_effect := item.battle_effect.resolve_effect()
		if battle_effect:
			var attempt := battle_effect.apply(self)
			_player_effect_history.append(attempt)

			event_texts.append("Player %s used %s!" % [player.name, item.name])
			event_texts.append_array(attempt.attempt_texts)
		else:
			event_texts.append("Player %s did not move!" % player.name)
	else:
		event_texts.append("No item at index %d" % index)

	events_occurred.emit(event_texts, player)

	CustomLogger.debug("Player effect history: %d effect(s)" % _player_effect_history.size())

func do_enemy_first_phase() -> void:
	_is_enemy_turn = true

	var first_phase_event_texts := _process_enemy_first_phase()
	events_occurred_enemy_first_phase.emit(first_phase_event_texts, enemy)

func _process_enemy_first_phase() -> Array[String]:
	var event_texts: Array[String] = []

	if not _enemy_queued_effects.is_empty():
		event_texts.append("Before enemy %s attacks..." % enemy.name)

	while not _enemy_queued_effects.is_empty():
		var effect: BattleEffect = _enemy_queued_effects.pop_front()
		var attempt := effect.apply(self)

		event_texts.append_array(attempt.attempt_texts)

	return event_texts

func do_enemy_main_phase() -> void:
	var main_phase_event_texts := _process_enemy_main_phase()
	events_occurred.emit(main_phase_event_texts, enemy)

	CustomLogger.debug("Enemy effect history: %d effect(s)" % _enemy_effect_history.size())

func _process_enemy_main_phase() -> Array[String]:
	var event_texts: Array[String] = []

	if _enemy_skips > 0:
		event_texts.append("Enemy %s skipped their turn." % enemy.name)
		_enemy_skips -= 1
	else:
		var battle_effect := _next_enemy_effect
		if battle_effect:
			if battle_effect.has_damage() and _enemy_damage_misses > 0:
				event_texts.append("Enemy %s attacked but missed!" % enemy.name)
				_enemy_damage_misses -= 1
			else:
				var attempt := battle_effect.apply(self)
				_enemy_effect_history.append(attempt)

				if attempt.has_queue():
					_enemy_queued_effects.append_array(attempt.get_queue())

				event_texts.append("Enemy %s attacked!" % enemy.name)
				event_texts.append_array(attempt.attempt_texts)
		else:
			event_texts.append("Enemy %s did not move!" % enemy.name)

	return event_texts

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
