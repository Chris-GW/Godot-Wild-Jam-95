@tool
class_name RepeatLastDamageEffect
extends BattleEffect

@export
var repeat_count := 1

func apply(battle: Battle) -> EffectAttempt:
	var attempt := RepeatEffectAttempt.new(self)

	var last_attempt = battle.get_last_attempt()

	if not last_attempt:
		attempt.attempt_texts.append("But there was no effect to repeat!")
		return attempt

	if not last_attempt.can_repeat():
		attempt.attempt_texts.append("But the last effect could not be repeated!")
		return attempt

	if last_attempt.damage_dealt <= 0:
		attempt.attempt_texts.append("But the last effect did not deal damage!")
		return attempt

	for i in repeat_count:
		var repeat_attempt := last_attempt.get_effect().apply(battle)
		attempt.add_attempt(repeat_attempt)

	attempt.complete()
	return attempt
