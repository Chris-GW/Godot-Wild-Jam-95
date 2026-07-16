@tool
class_name DamageBattlerEffect
extends BattleEffect

@export
var battler_resolver: BattlerResolver

@export
var damage_resolver: NumberResolver

func apply(battle: Battle) -> EffectAttempt:
	var attempt := EffectAttempt.new(self)

	if not battler_resolver:
		attempt.attempt_texts.append("But it didn't work!")
		return attempt

	if not damage_resolver:
		attempt.attempt_texts.append("But it didn't work!")
		return attempt

	var battler = battler_resolver.resolve(battle)
	attempt.target = battler

	if battler and not battler.is_dead():
		attempt.target_was_valid = true
		attempt.did_hit = true
		attempt.damage_dealt = battler.take_damage(damage_resolver)
		attempt.attempt_texts.append("Hit %s for %d damage!" % [battler.name, attempt.damage_dealt])

	return attempt

func can_apply(_battle: Battle) -> bool:
	return true

func can_repeat() -> bool:
	return true

func has_damage() -> bool:
	return true
