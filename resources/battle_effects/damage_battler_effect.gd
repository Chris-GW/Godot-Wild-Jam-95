class_name DamageBattlerEffect
extends BattleEffect

@export
var battler_resolver: BattlerResolver

@export
var damage_resolver: NumberResolver

var _did_hit := false

func apply(battle: Battle) -> void:
	if not battler_resolver:
		CustomLogger.info("No battler resolver is set")
		return

	if not damage_resolver:
		CustomLogger.info("No damage resolver is set")
		return

	var battler := battler_resolver.resolve(battle)
	if battler:
		battler.take_damage(damage_resolver)
		_did_hit = true

func can_repeat() -> bool:
	return true

func did_apply() -> bool:
	return _did_hit

func did_deal_damage() -> bool:
	return _did_hit
