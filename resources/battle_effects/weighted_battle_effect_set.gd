@tool
class_name WeightedBattleEffectSet
extends BattleEffect

@export
var effects: Array[BattleEffect] = []

@export
var weights: PackedFloat32Array = []

var _rng := RandomNumberGenerator.new()
var _chosen_effect: BattleEffect = null

func resolve_effect() -> BattleEffect:
	var random_index := _rng.rand_weighted(weights)
	_chosen_effect = effects[random_index]

	CustomLogger.debug("Weighted effect set resolved effect %s" % _chosen_effect.resource_path)

	return self

func apply(battle: Battle) -> EffectAttempt:
	var attempt := ParentEffectAttempt.new(_chosen_effect)

	if not _chosen_effect:
		attempt.attempt_texts.append("But an effect was not chosen!")
		return attempt

	var child_attempt := _chosen_effect.apply(battle)

	attempt.set_child_attempt(child_attempt)
	attempt.complete()

	return attempt

func can_apply(battle: Battle) -> bool:
	return _chosen_effect and _chosen_effect.can_apply(battle)

func has_damage() -> bool:
	return _chosen_effect and _chosen_effect.has_damage()

func has_healing() -> bool:
	return _chosen_effect and _chosen_effect.has_healing()
