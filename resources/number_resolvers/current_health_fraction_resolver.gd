## Resolves a number equal to the given current health multiplied by a factor.
class_name CurrentHealthFractionResolver
extends NumberResolver

@export
var battler_resolver: BattlerResolver

@export
var factor := 0.5

func resolve() -> float:
	var battler := battler_resolver.resolve(BattleManager.get_current())
	return maxf(1.0, factor * float(battler.health.current_health))
