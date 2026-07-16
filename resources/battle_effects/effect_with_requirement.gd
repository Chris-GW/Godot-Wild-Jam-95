@tool
class_name EffectWithRequirement
extends BattleEffect

@export
var requirement: EffectRequirement

@export
var effect: BattleEffect

func apply(battle: Battle) -> EffectAttempt:
	var attempt := ParentEffectAttempt.new(self)

	if not requirement.is_satisfied(battle):
		var requirement_failed_text := requirement.get_failed_text(battle)
		if requirement_failed_text.length() > 0:
			attempt.attempt_texts.append(requirement.get_failed_text(battle))
		else:
			attempt.attempt_texts.append("But the requirement was not satisfied!")

		return attempt

	requirement.apply(battle)

	var child_attempt := effect.apply(battle)

	var requirement_applied_text := requirement.get_applied_text(battle)
	if requirement_applied_text.length() > 0:
		attempt.attempt_texts.append(requirement_applied_text)

	attempt.set_child_attempt(child_attempt)
	attempt.complete()

	return attempt
