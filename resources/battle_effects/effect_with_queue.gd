## An effect that contains a list of "queued effects", which will be executed at
## the start of the user's next turn.
## CURRENTLY ONLY WORKS FOR THE ENEMY, NOT FOR THE PLAYER!
@tool
class_name EffectWithQueue
extends BattleEffect

@export
var queued_effects: Array[BattleEffect] = []

@export
var effect: BattleEffect

func apply(battle: Battle) -> EffectAttempt:
	var attempt := EffectWithQueueAttempt.new(self)

	var child_attempt := effect.apply(battle)

	attempt.set_child_attempt(child_attempt)
	attempt.set_queue(queued_effects)
	attempt.complete()

	return attempt

func can_apply(battle: Battle) -> bool:
	return effect and effect.can_apply(battle)

func has_damage() -> bool:
	return effect and effect.has_damage()

func has_healing() -> bool:
	return effect and effect.has_healing()
