@tool
class_name HealBattlerEffect
extends BattleEffect

@export
var battler_resolver: BattlerResolver

@export
var healing_resolver: NumberResolver

func apply(battle: Battle) -> EffectAttempt:
	var attempt := HealingEffectAttempt.new(self)

	if not battler_resolver:
		attempt.attempt_texts.append("But it didn't work!")
		return attempt

	if not healing_resolver:
		attempt.attempt_texts.append("But it didn't work!")
		return attempt

	var battler = battler_resolver.resolve(battle)
	attempt.target = battler

	if battler and not battler.is_dead():
		attempt.target_was_valid = true
		attempt.did_hit = true
		attempt.amount_healed = battler.heal(healing_resolver)
		attempt.attempt_texts.append("Healed %s for %dHP!" % [battler.name, attempt.amount_healed])

	return attempt

func can_apply(battle: Battle) -> bool:
	var battler = battler_resolver.resolve(battle)
	return battler and not battler.is_dead()

func has_healing() -> bool:
	return true
