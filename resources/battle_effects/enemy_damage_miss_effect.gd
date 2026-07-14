class_name EnemyDamageMissEffect
extends BattleEffect

func apply(battle: Battle) -> EffectAttempt:
	var attempt := EffectAttempt.new(self)

	var enemy := battle.enemy
	attempt.target = enemy

	if enemy and not enemy.is_dead():
		battle.add_enemy_damage_miss()

		attempt.target_was_valid = true
		attempt.did_hit = true

		# TODO: this isn't always correct, since the number of enemy misses can
		# be greater than one. But for the current set of items, it is correct.
		attempt.attempt_texts.append("Enemy %s will miss its next attack!" % enemy.name)

	return attempt

func can_apply(battle: Battle) -> bool:
	return battle.enemy and not battle.enemy.is_dead()
